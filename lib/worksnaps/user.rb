# frozen_string_literal: true

module Worksnaps
  class User
    attr_accessor :api_response,
                  :api_token,
                  :email,
                  :first_name,
                  :id,
                  :last_name,
                  :login,
                  :timezone,
                  :token

    def initialize(api_response, client, token)
      @client = client
      @token = token

      @api_response = api_response
      @api_token = api_response.dig(:api_token)
      @email = api_response.dig(:email)
      @first_name = api_response.dig(:first_name)
      @id = api_response.dig(:id)
      @last_name = api_response.dig(:last_name)
      @login = api_response.dig(:login)

      dst = api_response.dig(:is_in_daylight_time) == 'true'
      @timezone = Timezone.new(api_response.dig(:timezone_id)&.to_i, dst)
    end

    def projects
      @client.projects
    end
  end
end
