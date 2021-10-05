# frozen_string_literal: true

module Worksnaps
  class TimeEntry
    attr_accessor :api_response,
                  :activity_level,
                  :client,
                  :created_at,
                  :created_on,
                  :from_timestamp,
                  :minutes,
                  :notes,
                  :project,
                  :screenshot_thumbnail,
                  :screenshot,
                  :task_name,
                  :task_id,
                  :timezone,
                  :user

    def initialize(api_response, client, user, project)
      @client = client
      @project = project
      @timezone = user.timezone
      @user = user

      @api_response = api_response
      @activity_level = api_response.dig(:activity_level)&.to_i
      @from_timestamp = api_response.dig(:from_timestamp)
      @minutes = api_response.dig(:duration_in_minutes)&.to_i || 0
      @notes = api_response.dig(:user_comment)
      @project = project
      @screenshot = api_response.dig(:full_resolution_url)
      @screenshot_thumbnail = api_response.dig(:thumbnail_url)
      @task_id = api_response.dig(:task_id)
      @task_name = api_response.dig(:task_name)

      Time.zone = @timezone.to_activesupport.name

      @created_at = if api_response.dig(:logged_timestamp).blank?
                      nil
                    else
                      Time.zone.parse(
                        @client.strip_timezone(
                          Time.at(
                            api_response.dig('logged_timestamp').to_i
                          )
                        )
                      )
                    end
      @created_on = @created_at.blank? ? nil : Time.zone.parse(@created_at.to_date.to_s)
    end
  end
end
