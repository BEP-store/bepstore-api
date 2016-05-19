class Role
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  field :title, type: String

  belongs_to :group

  validates :group, presence: true
end
