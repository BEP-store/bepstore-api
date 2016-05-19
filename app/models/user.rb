class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  has_many :activities

  field :id, type: Integer
  field :name, type: String
  field :account_id, type: String

  validates :name, presence: true

  def enroll!(group, role)
  end

  def enrolled?(group)
  end
end
