class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  has_many :activities

  field :id, type: Integer
  def enroll!(group, role)
  end

  def enrolled?(group)
  end
end
