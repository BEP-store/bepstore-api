class Resource
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  belongs_to :goal

  field :route
  field :type

  validates :route, presence: true
  validates :type, presence: true

  def id
    route
  end
end
