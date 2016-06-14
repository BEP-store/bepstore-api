class UserSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :name, :bio

  def type
    binding.pry
    object._type.underscore #.dasherize
  end
end
