module Support
  module RequestHelpers
    def get_api(path)
      get path, headers: headers
    end

    def post_api(path, params = nil)
      post path, params: params.to_json, headers: headers
    end

    def put_api(path, params = nil)
      put path, params: params.to_json, headers: headers
    end

    def delete_api(path, params = nil)
      delete path, params: params.to_json, headers: headers
    end

    def json_response
      HashWithIndifferentAccess.new(JSON.parse(response.body))
    end

    private

    def headers
      {
        'Content-Type' => 'application/json'
      }
    end
  end
end

RSpec.configure do |config|
  config.include Support::RequestHelpers, type: :request
end
