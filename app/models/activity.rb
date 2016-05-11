class Activity
  include Mongoid::Document
  include Mongoid::Timestamps

  field :engine, type: String, default: -> { self.class.engine }, pre_processed: true

  validates :engine, presence: true

  # :nocov:
  def self.engine
    name.underscore.pluralize
  end
end
