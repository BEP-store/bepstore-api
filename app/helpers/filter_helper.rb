module FilterHelper
  private

  def set_filter
    @filter = params[:filter].transform_values do |value|
      value.split(',')
    end
  end
end
