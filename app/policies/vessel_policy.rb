class VesselPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      scope.where(id: user.managed_vessels.select(:id))
    end

    private

    attr_reader :user, :scope
  end

  def index?
    true
  end

  def show?
    managing_vessel?(record)
  end

  def create?
    true
  end

  def update?
    managing_vessel?(record)
  end

  def destroy?
    managing_vessel?(record)
  end

  private

  def managing_vessel?(record)
    user.managed_vessels.where(id: record.id).exists?
  end
end
