# frozen_string_literal: true

module Worksnaps
  class TimeEntry
    attr_accessor :api_response,
                  :activity_level,
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
                  :type,
                  :user

    def initialize(api_response, user, project)
      @project = project
      @timezone = user.timezone
      @type = api_response.dig(:type)
      @user = user

      @api_response = api_response
      @activity_level = api_response.dig(:activity_level)&.to_i
      @from_timestamp = api_response.dig(:from_timestamp)
      @minutes = api_response.dig(:duration_in_minutes)
      @notes = api_response.dig(:user_comment)
      @project = project
      @screenshot = api_response.dig(:full_resolution_url)
      @screenshot_thumbnail = api_response.dig(:thumbnail_url)
      @task_id = api_response.dig(:task_id)
      @task_name = api_response.dig(:task_name)

      @created_at = if api_response.dig(:logged_timestamp).blank?
                      nil
                    else
                      Time.at(api_response.dig(:logged_timestamp).to_i).to_datetime
                    end
      @created_on = @created_at.blank? ? nil : @created_at.to_date
    end

    def to_hash
      {
        api_response: @api_response,
        activity_level: @activity_level,
        created_at: @created_at,
        from_timestamp: @from_timestamp,
        minutes: @minutes,
        notes: @notes,
        project: @project,
        screenshot_thumbnail: @screenshot_thumbnail,
        screenshot: @screenshot,
        task_name: @task_name,
        task_id: @task_id,
        timezone: @timezone,
        type: @type,
        user: @user
      }
    end

  end
end
