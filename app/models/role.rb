class Role < ActiveRecord::Base
  # field :title, type: String

  has_one :group

  validates :group, presence: true
end
