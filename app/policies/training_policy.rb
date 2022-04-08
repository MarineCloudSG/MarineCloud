class TrainingPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      scope.joins(training_plan: :client).where(clients: { user_id: user.id })
    end

    private

    attr_reader :user, :scope
  end

  def show?
    owner_of_client?
  end

  def create?
    true
  end

  def update?
    owner_of_client?
  end

  def destroy?
    owner_of_client?
  end

  private

  def owner_of_client?
    owner_of?(record.training_plan.client)
  end
end
