# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class GoalChannel < ApplicationCable::Channel
  def appear(message)
    # appearance.group_id = message['group_id']
    # appearance.activity_id = message['activity_id']
    # goal.title = message['title']
    # goal.description = 'desc'
    # goal.status = 'pending'
    # goal.save!
    g = Goal.create(title: '11234', description: "A desc", status: "pending")
    redis.sadd("activity_"+message['id']+"_store", message['id'])
  end

  def subscribed
    stream_resource_updates_from "goals"
    ActionCable.server.broadcast "goal", {
       action: 'updates',
       id: '57582d552a71752cbf8d1498',
       type: 'Goal'
     }
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def create(obj)
    Goal.create! :title=>obj.title, :description=>"A desc", :status=>"pending"
  end
end
