class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :type, :created_at, :engine

  has_one :user
  has_many :parents
  has_many :children

  def type
    # binding.pry
    object._type.underscore #.dasherize
  end
end
