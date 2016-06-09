class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia
  include ActiveModel::Serializers::JSON

  has_and_belongs_to_many :activities

  field :name, type: String
  field :admin, type: Boolean, default: false
  field :bio, type: String
  field :account_id, type: String

  validates :name, presence: true

  def enroll!(group, role)
  end

  def enrolled?(group)
  end

  def self.create_from_account!(account)
    user = User.new(name: account[:name], admin: false, account_id: account[:id])
    user.save!
    user
  end
end
