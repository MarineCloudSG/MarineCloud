module Vessels
  class CommentCreatedEvent < PubSub::DomainEvent
    attribute :comment_id, Types::Strict::Integer
    attribute :vessel_id, Types::Strict::Integer
    attribute :message_text, Types::Strict::String
  end
end
