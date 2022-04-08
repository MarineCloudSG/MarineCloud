class TrainingPlanPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      scope.joins(:client).where(clients: { user_id: user.id })
    end

    private

    attr_reader :user, :scope
  end

  def index?
    true
  end

  def create?
    true
  end

  def update?
    owner_of?(record.client)
  end

  def destroy?
    owner_of?(record.client)
  end
end
