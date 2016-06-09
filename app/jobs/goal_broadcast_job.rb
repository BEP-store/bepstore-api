class GoalBroadcastJob < ApplicationJob
  queue_as :default

  def perform(comment)
    ActionCable.server.broadcast "goals",
    {
       action: 'create',
       id: '57582d552a71752cbf8d1498',
       type: 'Goal'
     }
  end
end
