# frozen_string_literal: true

module Worksnaps
  class Summary
    attr_accessor :activities,
                  :api_response,
                  :api_token,
                  :from_date,
                  :to_date

    def initialize(api_response, client, token, from_date, to_date)
      @client = client
      @token = token
      @from_date = from_date
      @to_date = to_date

      @activities = api_response
    end
  end
end
