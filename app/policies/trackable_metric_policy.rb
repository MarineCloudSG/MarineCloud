class TrackableMetricPolicy < ApplicationPolicy
  def create?
    true
  end

  def update?
    owner_of?(record.client)
  end
end
