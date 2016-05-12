class ActivityObserver < Mongoid::Observer
  observe Activity._types

  # def after_save(activity)
  #   Activity.delay.ensure_notifications!(activity.id)
  # end

  # def after_create(activity)
  #   Activity.delay.fill_bundles!(activity.id)
  # end

  # def after_update(activity)
  #   Activity.delay.fill_bundles!(activity.id) if activity.tags_changed?
  # end
end
