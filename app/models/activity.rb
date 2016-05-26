class Activity
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user

  has_and_belongs_to_many :parents, inverse_of: :children, class_name: 'Activity', autosave: true
  has_and_belongs_to_many :children, inverse_of: :parents, class_name: 'Activity'

  has_and_belongs_to_many :groups

  field :engine, type: String, default: -> { self.class.engine }, pre_processed: true

  validates :engine, presence: true

  def self.engine
    name.underscore.pluralize
  end
end
