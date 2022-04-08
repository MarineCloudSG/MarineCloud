module Subscriptions
  class AccountsNewUserRegisteredHandler < PubSub::DomainEventHandler
    def call
      user.set_payment_processor :fake_processor, allow_fake: true
      user.payment_processor.subscribe(trial_ends_at: trial_ends_at, ends_at: trial_ends_at)
    end

    private

    def trial_ends_at
      @trial_ends_at ||= Date.current + Subscriptions::TRIAL_DAYS
    end

    def user
      User.find(event_data.user_id)
    end
  end
end
