class ActivitySerializer < ActiveModel::Serializer
  embed :ids

  attributes :id, :created_at, :type, :engine

  def type
    object._type.underscore
  end
end
