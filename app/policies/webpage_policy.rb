class WebpagePolicy < ApplicationPolicy
  def update?
    owner_of?(record)
  end
end
