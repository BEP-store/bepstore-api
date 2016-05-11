module ApiHelper
  def resource_name
    params[:controller].split('/').last.singularize
  end

  def resource_class
    resource_name.camelize.constantize
  end
end
