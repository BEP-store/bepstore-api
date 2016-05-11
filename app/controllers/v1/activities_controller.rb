module V1
  class ActivitiesController < ApiController
    include ActivitiesHelper
    include PaginationHelper

    before_action :find_activity, only: [:show, :update, :destroy]

    def index
      @activities = policy_scope(resource_class)

      @activities = @activities.unbundled.where(:_type.nin => %w(View Folder Text)) if resource_name == 'activity'
      @activities = @activities.desc(:created_at).page(page).per(per_page)

      authorize @activities

      render json: @activities, root: root, meta: {
        page: page,
        per_page: per_page,
        total_pages: @activities.total_pages
      }
    end

    def find
      @activities = policy_scope(resource_class).find(params[:ids])
      authorize Activity
      render json: @activities, root: root
    end

    def show
      authorize @activity
      render json: @activity, root: root
    end

    def create
      @activity = resource_class.new create_params
      authorize @activity
      if @activity.save
        render json: @activity, root: root, status: :created
      else
        render json: { errors: @activity.errors }, status: :unprocessable_entity
      end
    end

    def update
      authorize @activity
      if @activity.update update_params
        render json: @activity, root: root
      else
        render json: { errors: @activity.errors }, status: :unprocessable_entity
      end
    end

    def destroy
      authorize @activity
      if @activity.destroy
        render json: {}, status: :accepted
      else
        render json: { errors: @activity.errors }, status: :unprocessable_entity
      end
    end

    private

    def create_params
      permitted_attributes(resource_class, :create).merge(
        user: current_user
      )
    end

    def update_params
      permitted_attributes(resource_class, :update).merge(
        )
    end
  end
end
