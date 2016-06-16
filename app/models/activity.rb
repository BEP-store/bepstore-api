class Activity
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic
  include ActiveModel::Serializers::JSON

  scope :type, -> (type) { where(_type: type.to_s.classify) }

  belongs_to :user, index: true

  has_and_belongs_to_many :parents, inverse_of: :children, class_name: 'Activity', index: true
  has_and_belongs_to_many :children, inverse_of: :parents, class_name: 'Activity', index: true

  has_and_belongs_to_many :groups, index: true

  field :engine, type: String, default: -> { self.class.engine }, pre_processed: true

  validates :engine, presence: true

  def self.engine
    name.underscore.pluralize
  end
end
