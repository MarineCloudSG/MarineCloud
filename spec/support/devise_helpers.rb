module DeviseRequestSpecHelpers
  include Warden::Test::Helpers

  def create_user_and_sign_in
    user = build(:user)
    user.skip_confirmation!
    user.save!
    sign_in user
    user
  end

  def sign_in(resource_or_scope, resource = nil)
    resource ||= resource_or_scope
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    login_as(resource, scope: scope)
  end

  def sign_out(resource_or_scope)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    logout(scope)
  end
end

RSpec.configure do |config|
  config.include DeviseRequestSpecHelpers, type: :request
end
