module ApiHelper
  private

  def resource_name
    if params[:type].present?
      params[:type]
    elsif params.dig(:data, :type).present?
      params.dig(:data, :type).singularize
    else
      params[:controller].split('/').last.singularize
    end
  end

  def resource_class
    resource_name.camelize.constantize
  end

  def permitted_attributes(record, action = params[:action])
    policy = policy(record)
    method_name = if policy.respond_to?("permitted_attributes_for_#{action}")
      "permitted_attributes_for_#{action}"
    else
      'permitted_attributes'
    end
    ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: policy.public_send(method_name))
  end
end
