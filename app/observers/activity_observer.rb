class ActivityObserver < Mongoid::Observer
  observe Activity._types

  # def after_save(activity)
  #   Activity.delay.ensure_notifications!(activity.id)
  # end

  def after_create(activity)
    ActionCable.server.broadcast("goal_#{activity.id}", {
      action: 'create',
      id: activity.id,
      type: activity._type
    })
  end

  def after_update(activity)
    ActionCable.server.broadcast("goal_#{activity.id}", {
      action: 'update',
      id: activity.id,
      type: activity._type
    })
  end

  def after_destroy(activity)
    # activity.groups.each do |group|
    #   ActionCable.server.broadcast("news_#{group.id}", {
    #     action: 'destroy',
    #     id: activity.id,
    #     type: activity._type
    #   })
    # end
  end
end
