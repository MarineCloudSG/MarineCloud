RSpec.configure do |config|
  config.before :each do
    handle_request_exceptions(false)
  end
end
