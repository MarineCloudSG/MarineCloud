class ProductPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      scope.where(user_id: user.id)
    end

    private

    attr_reader :user, :scope
  end

  def index?
    true
  end

  def show?
    owner_of?(record)
  end

  def create?
    true
  end

  def update?
    owner_of?(record)
  end

  def destroy?
    owner_of?(record)
  end
end
