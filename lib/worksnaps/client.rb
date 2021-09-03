# frozen_string_literal: true

module Worksnaps
  class Client
    # include Timezone

    API_PATH = 'https://api.worksnaps.com/api'
    API_ENDPOINTS = {
      profile: '/me.xml',
      projects: '/projects.xml',
      project_minutes_worked: '/projects/%PROJECT_ID%/reports.xml?name=time_summary&from_timestamp=%FROM_TIMESTAMP%&to_timestamp=%TO_TIMESTAMP%&user_ids=%USER_ID%',
      project_time_entries: '/projects/%PROJECT_ID%/users/%USER_ID%/time_entries.xml?from_timestamp=%FROM_TIMESTAMP%&to_timestamp=%TO_TIMESTAMP%',
      project_user_assignments: '/projects/%PROJECT_ID%/user_assignments.xml',
      summary: '/summary_reports.xml?name=manager_report&from_date=%FROM_TIMESTAMP%&to_date=%TO_TIMESTAMP%'
    }.freeze

    attr_accessor :projects, :summary, :user

    def initialize(token = nil)
      @token = token || ENV['WORKSNAPS_API_TOKEN']
      @user = nil
    end

    def commit(action, options = {})
      url = if options.dig(:url)
              API_PATH + options.dig(:url)
            else
              API_PATH + API_ENDPOINTS[action]
            end

      response = if options[:request]
                   HTTParty.post(url, basic_auth: auth)
                 else
                   HTTParty.get(url, body: options[:request], basic_auth: auth)
                 end

      if response&.body
        xml = Nokogiri::XML(response.body).to_xml
        response = Hash.from_xml(xml).with_indifferent_access
        error_string = response.dig(:reply, :error_string)
        extra_info = response.dig(:reply, :extra_info)

        unless error_string.blank?
          if extra_info.blank?
            raise "API Error: #{error_string}"
          else
            raise "API Error: #{error_string} -> #{extra_info}"
          end
        end

        return response
      end

      nil
    end

    def user
      @user ||= parse_user_response(commit(:profile))
    end

    def projects
      @projects ||= parse_projects_response(commit(:projects))
    end

    def summary(from_date, to_date)
      from_date = to_date - 1.day if from_date == to_date

      url = Client::API_ENDPOINTS[:summary]
      url = url.sub('%FROM_TIMESTAMP%', from_date.to_s)
      url = url.sub('%TO_TIMESTAMP%', to_date.to_s)

      @summary ||= parse_summary_response(commit(:summary, url: url), from_date, to_date)
    end

    def strip_timezone(datetime)
      datetime.class == Date ? datetime.to_s : datetime.to_s.sub('T', ' ')[0..-7]
    end

    private

    def auth
      { username: @token, password: 'ignored' }
    end

    def parse_user_response(response)
      return nil if response.dig(:user).blank?
      User.new(response.dig(:user), self, @token)
    end

    def parse_projects_response(response)
      projects = []
      api_responses = response&.dig(:projects)&.to_a&.inject([]) { |arr, project| arr << project[1] }

      unless api_responses.blank?
        api_responses.each do |api_response|
          projects << Project.new(api_response, client = self)
        end

        return projects
      end

      nil
    end

    def parse_summary_response(response, from_date, to_date)
      response = response&.dig(:manager_report)&.dig(:line_item)
      Summary.new(response, self, @token, from_date, to_date) if response
    end
  end
end
