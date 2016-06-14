module ActivitiesHelper
  def engine?
    resource_name != 'activity'
  end

#   def root
#     if @activity.present?
#       if engine?
#         resource_name
#       else
#         'activity'
#       end
#     else
#       if engine?
#         resource_name.pluralize
#       else
#         'activities'
#       end
#     end
#   end
end
