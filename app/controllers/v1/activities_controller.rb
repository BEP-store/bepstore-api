module V1
  class ActivitiesController < ApiController
    include ActivitiesHelper
    include PaginationHelper

    before_action :find_parent, only: :index
    before_action :find_activity, only: [:show, :update, :destroy]

    def index
      @activities = resource_class
      @activities = @activities.in(parent_ids: @activity.id) if defined?(@activity)
      @activities = @activities.desc(:created_at).page(page).per(per_page)

      render json: @activities, root: root, meta: {
        page: page,
        per_page: per_page,
        total_pages: @activities.total_pages
      }
    end

    def find
      @activities = resource_class.find(params[:ids])
      render json: @activities, root: root
    end

    def show
      render json: @activity, root: root
    end

    def create
      @activity = resource_class.new create_params
      if @activity.save
        render json: @activity, root: root, status: :created
      else
        render json: { errors: @activity.errors }, status: :unprocessable_entity
      end
    end

    def update
      if @activity.update update_params
        render json: @activity, root: root
      else
        render json: { errors: @activity.errors }, status: :unprocessable_entity
      end
    end

    def destroy
      if @activity.destroy
        render json: {}, status: :accepted
      else
        render json: { errors: @activity.errors }, status: :unprocessable_entity
      end
    end

    private

    def create_params
      params.require(:goal).permit(:title, :description, :status, :parents)
    end

    def update_params
      params.require(:goal).permit(:title, :description, :status, :parents)
    end

    def find_activity
      @activity = resource_class.find(params[:id])
    end

    def find_parent
      @parent = Activity.find(params[:activity_id]) if params.key?(:activity_id)
    end
  end
end
