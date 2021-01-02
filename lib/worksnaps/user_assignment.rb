# frozen_string_literal: true

module Worksnaps
  class UserAssignment
    attr_accessor :api_response,
                  :flag_allow_logging_time,
                  :id,
                  :project,
                  :role,
                  :user,
                  :window_for_adding_offline_time,
                  :window_for_deleting_time

    def initialize(api_response, user, project)
      @project = project
      @timezone = user.timezone
      @user = user

      @api_response = api_response
      @flag_allow_logging_time = api_response.dig(:flag_allow_logging_time)
      @id = api_response.dig(:id)
      @role = api_response.dig(:role)
      @window_for_adding_offline_time = api_response.dig(:window_for_adding_offline_time)
      @window_for_deleting_time = api_response.dig(:window_for_deleting_time)
    end
  end
end
