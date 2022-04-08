module Accounts
  class NewUserRegisteredEvent < PubSub::DomainEvent
    attribute :user_id, Types::Strict::Integer
  end
end
