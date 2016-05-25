class Activity
  include Mongoid::Document
  include Mongoid::Timestamps

  scope :root, -> { where(:$or => [{ parent_ids: { :$size => 0 } }, { parent_ids: nil }]) }

  belongs_to :user

  has_and_belongs_to_many :parents, inverse_of: :children, class_name: 'Activity', autosave: true
  has_and_belongs_to_many :children, inverse_of: :parents, class_name: 'Activity'

  has_and_belongs_to_many :groups

  field :engine, type: String, default: -> { self.class.engine }, pre_processed: true

  validates :engine, presence: true

  def siblings
    Activity.in(parent_ids: parent_ids).nin(id: id)
  end

  def family
    Activity.where(:$or => [
      { :parent_ids.in => parent_ids },
      { :id.in => parent_ids }
    ]).nin(id: id)
  end

  def self.engine
    name.underscore.pluralize
  end
end
