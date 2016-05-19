class User
  include ActiveModel::Model
  
  has_many :activities

  field :id, type: Integer
  def enroll!(group, role)
  end

  def enrolled?(group)
  end
end
