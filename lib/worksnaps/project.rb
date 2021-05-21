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

    def minutes_worked(from, to)
      from, to = dates_to_timestamps(from, to)

      url = Client::API_ENDPOINTS[:project_minutes_worked]
      url = url.sub('%PROJECT_ID%', @id)
      url = url.sub('%USER_ID%', @client.user.id)
      url = url.sub('%FROM_TIMESTAMP%', from.to_i.to_s)
      url = url.sub('%TO_TIMESTAMP%', to.to_i.to_s)
      url = url.sub('%USER_ID%', @client.user.id.to_s)

      parse_minutes_worked_response(@client.commit(:project_minutes_worked, url: url))
    end

    def time_entries(from, to)
      return @time_entries unless @time_entries.blank?

      from, to = dates_to_timestamps(from, to)

      url = Client::API_ENDPOINTS[:project_time_entries]
      url = url.sub('%PROJECT_ID%', @id)
      url = url.sub('%USER_ID%', @client.user.id)
      url = url.sub('%FROM_TIMESTAMP%', from.to_i.to_s)
      url = url.sub('%TO_TIMESTAMP%', to.to_i.to_s)

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

    def dates_to_timestamps(from, to)
      Time.zone = client.user.timezone.to_activesupport.name

      from = Time.zone.parse(
        client.strip_timezone(
          from.to_datetime.beginning_of_day
        ).to_s
      )
      to = Time.zone.parse(
        client.strip_timezone(
          (to.to_datetime + 1.day).beginning_of_day
        ).to_s
      )

      [ from, to ]
    end

    def parse_minutes_worked_response(response)
      begin
        response&.dig(:time_summary, :time_entry, :duration_in_minutes).to_i
      rescue StandardError
        response&.dig(:time_summary, :time_entry).inject(0) { |sum, time_entry| sum += time_entry[:duration_in_minutes].to_i }
      end
    end

    def parse_time_entries_response(response)
      time_entries = []
      api_responses = response&.dig(:time_entries)&.to_a&.inject([]) { |arr, time_entry| arr << time_entry[1] }&.first

      unless api_responses.blank?
        api_responses.each do |api_response|
          time_entries << TimeEntry.new(api_response, @client, @client.user, self)
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
