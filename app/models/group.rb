class Group
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia
  include ActiveModel::Serializers::JSON

  has_and_belongs_to_many :activities
end
