class UserSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :name, :bio
end
