module PaginationHelper
  private

  def per_page
    params[:per_page] || 20
  end

  def page
    params[:page] || 1
  end
end
