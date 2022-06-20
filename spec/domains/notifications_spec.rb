require 'rails_helper'

RSpec.describe Notifications, subscribers: true do
  it { is_expected.to subscribe_to(:vessels__comment_created).asynchronously }
end
