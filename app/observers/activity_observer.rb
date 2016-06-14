class ActivityObserver < Mongoid::Observer
  observe Activity._types

  def after_create(activity)
    ActionCable.server.broadcast('goals', action: 'create',
                                          id: activity.id,
                                          type: activity._type)
  end

  def after_update(activity)
    ActionCable.server.broadcast('goals', action: 'update',
                                          id: activity.id,
                                          type: activity._type)
  end

  def after_destroy(activity)
    ActionCable.server.broadcast('goals', action: 'destroy',
                                          id: activity.id,
                                          type: activity._type)
  end
end
