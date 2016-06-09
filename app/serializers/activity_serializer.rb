class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :created_at, :type, :engine

  has_one :user
  has_many :parents, polymorphic: true
  has_many :children, polymorphic: true

  def type
    object._type.underscore
  end
end
