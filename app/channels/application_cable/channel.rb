# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
module ApplicationCable
  class Channel < ActionCable::Channel::Base
    def current_user
      the_current_user
    end

    def map_to_resource_update(message)
      message = message.symbolize_keys
      return message if message[:action] == 'destroy'

      resource_class = message[:_type].constantize
      resource = Pundit.policy_scope(current_user, resource_class).find(message[:id])
      return unless resource.present?

      serialization = ActiveModelSerializers::SerializableResource.new(resource, scope: current_user)
      message.merge(payload: serialization.as_json)
    end

    def stream_resource_updates_from(topic)
      stream_from topic, coder: ActiveSupport::JSON do |message|
        transmit(map_to_resource_update(message))
      end
    end

    def redis
      Redis.current
    end
  end
end
