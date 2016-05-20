require 'active_record'

class Activity < ActiveRecord::Base

  belongs_to :user

  has_and_belongs_to_many :parents, inverse_of: :children, class_name: 'Activity', autosave: true
  has_and_belongs_to_many :children, inverse_of: :parents, class_name: 'Activity'

  has_and_belongs_to_many :groups

  # String engine
  # field :engine, type: String, default: -> { self.class.engine }, pre_processed: true

  validates :engine, presence: true

  # :nocov:
  def self.engine
    name.underscore.pluralize
  end
  # :nocov:
end
