# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class GoalChannel < ApplicationCable::Channel
  def subscribed
    stream_resource_updates_from "goals"
    ActionCable.server.broadcast "goals", {
       action: 'update',
       id: appearance.id,
       type: 'Appearance'
     }
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def create
    Goal.create! :title=>"Testasdf", :description=>"A desc", :status=>"pending"
  end
end
