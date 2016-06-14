class ActivityPolicy < ApplicationPolicy
  def index?
    true
  end

  def filter?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end

  def permitted_attributes_for_create
    [:engine, :created_at, :updated_at]
  end

  def permitted_attributes
    [:engine, :created_at, :updated_at, :data, :goal, :type]
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
