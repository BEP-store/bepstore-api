class ActivityPolicy < ApplicationPolicy
  def index?
    true
  end

  def find?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def permitted_attributes
    []
  end
end
