# frozen_string_literal: true

module Worksnaps
  class Project
    attr_accessor :api_response,
                  :client,
                  :id,
                  :active,
                  :description,
                  :name

    def initialize(api_response, client)
      @client = client

      @api_response = api_response
      @active = api_response.dig(:status)&.downcase == 'active'
      @description = api_response.dig(:description)
      @id = api_response.dig(:id)
      @name = api_response.dig(:name)
    end

    def active?
      @active
    end

    def time_entries(from_datetime, to_datetime)
      return @time_entries unless @time_entries.blank?

      url = Client::API_ENDPOINTS[:project_time_entries]
      url = url.sub('%PROJECT_ID%', @id)
      url = url.sub('%USER_ID%', @client.user.id)
      url = url.sub('%FROM_TIMESTAMP%', from_datetime.to_time.to_i.to_s)
      url = url.sub('%TO_TIMESTAMP%', to_datetime.to_time.to_i.to_s)

      @time_entries = parse_time_entries_response(@client.commit(:project_time_entries, url: url))
    end

    def user_assignments
      return @user_assignments unless @user_assignments.blank?

      url = Client::API_ENDPOINTS[:project_user_assignments]
      url = url.sub('%PROJECT_ID%', @id)

      # return @client.commit(:project_user_assignments, url: url)
      @user_assignments = parse_user_assignments_response(@client.commit(:project_user_assignments, url: url))
    end

    private

    def parse_time_entries_response(response)
      time_entries = []
      api_responses = response&.dig(:time_entries)&.to_a&.inject([]) { |arr, time_entry| arr << time_entry[1] }&.first

      unless api_responses.blank?
        api_responses.each do |api_response|
          time_entries << TimeEntry.new(api_response, @client.user, self)
        end

        return time_entries
      end

      nil
    end

    def parse_user_assignments_response(response)
      user_assignments = []
      api_responses = response&.dig('user_assignments')&.to_a&.inject([]) { |arr, user_assignment| arr << user_assignment[1] }

      unless api_responses.blank?
        api_responses.each do |api_response|
          user_assignments << UserAssignment.new(api_response, @client.user, self)
        end

        return user_assignments
      end

      nil
    end
  end
end
