# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
module ApplicationCable
  class Channel < ActionCable::Channel::Base
    def current_user
      the_current_user
    end

    def map_to_resource_update(message)
      message = message.symbolize_keys
      puts "test1"
      # puts "test2"
      # puts message[:_type]
      # puts "test3"
      return message if message[:action] == 'destroy'

      # puts "seri1"
      # puts message[:_type]
      puts "test4"
      resource_class = message[:_type].constantize
      puts "test5"
      resource = Pundit.policy_scope(current_user, resource_class).find(message[:id])
      puts "test6"
      return unless resource.present?
      puts "test7"
      # puts current_user['title']
      # puts "ser2"

      serialization = ActiveModelSerializers::SerializableResource.new(resource, scope: current_user)
      # puts "seri!!"
      # puts serialization['title']
      puts "test8"
      message.merge({
        payload: serialization.as_json
      })
    end

    def stream_resource_updates_from(topic)
      stream_from topic, coder: ActiveSupport::JSON do |message|
        # binding.pry
        # puts message
        # transmit(message)
        transmit(map_to_resource_update(message))
      end
    end

    def redis
      Redis.current
    end
  end
end
