class Role
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia
  include ActiveModel::Serializers::JSON

  field :title, type: String

  belongs_to :group

  validates :group, presence: true
end
