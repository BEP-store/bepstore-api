class UserSerializer < ActiveModel::Serializer
  embed :ids

  attributes :id, :created_at, :name
end
