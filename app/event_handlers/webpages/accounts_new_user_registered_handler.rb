module Webpages
  class AccountsNewUserRegisteredHandler < PubSub::DomainEventHandler
    def call
      Webpage.create(
        user_id: user.id,
        domain: DefaultDomainNameFromEmail.result_for(user.email)
      )
    end

    private

    def user
      @user ||= User.find(event_data.user_id)
    end
  end
end
