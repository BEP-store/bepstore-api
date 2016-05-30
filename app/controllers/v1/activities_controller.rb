module V1
  class ActivitiesController < ApiController
    include ActivitiesHelper
    include PaginationHelper

    before_action :find_parents, only: [:create, :update]
    before_action :find_activity, only: [:show, :update, :destroy]

    def index
      @activities = policy_scope(resource_class)
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
      @activity = policy_scope(resource_class).new create_params
      authorize @activity
      if @activity.save
        render json: @activity, root: root, status: :created
      else
        render json: { errors: @activity.errors }, status: :unprocessable_entity
      end
    end

    def update
      authorize @activity
      if(request.put?)
        @activity.update! update_params
        render json: @activity, root: root
      else
        #Do something with patch requests.
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
      permitted_attributes(resource_class).merge(
        user: current_user
      )
    end

    def update_params
      # binding.pry
      permitted_attributes(resource_class)
    end

    def find_group
      @group = policy_scope(Group).find(params[:group_id]) if params.key?(:group_id)
    end

    def find_parent
      @parent = policy_scope(Activity).find(params[:activity_id]) if params.key?(:activity_id)
    end

    def find_groups
      @groups = policy_scope(Group).find(params.try(:[], resource_name).try(:[], :group_ids) || [])
    end

    def find_parents
      @parents = policy_scope(Activity).find(params.try(:[], resource_name).try(:[], :parent_ids) || [])
    end

    def find_activity
      @activity = policy_scope(resource_class).find(params[:id])
    end
  end
end
