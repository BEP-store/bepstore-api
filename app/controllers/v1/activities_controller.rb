module V1
  class ActivitiesController < ApiController
    include PaginationHelper

    skip_before_action :signed_in_user, only: [:index, :filter, :show]
    before_action :find_activity, only: [:show, :update, :destroy]

    def index
      @activities = policy_scope(resource_class)
      @activities = @activities.desc(:created_at).page(page).per(per_page)

      authorize @activities

      render json: @activities, meta: {
        page: page,
        per_page: per_page,
        total_pages: @activities.total_pages
      }, include: included_relationships
    end

    def filter
      @activities = policy_scope(resource_class).in(@filter)
      authorize @activities
      render json: @activities
    end

    def show
      authorize @activity
      render json: @activity
    end

    def create
      @activity = policy_scope(resource_class).new create_params
      authorize @activity
      @activity.save!
      render json: @activity, status: :created
    end

    def update
      authorize @activity
      @activity.update! level_params
      render json: @activity
    end

    def destroy
      authorize @activity
      @activity.destroy!
      head :no_content
    end

    private

    def level_params
      ActiveModelSerializers::Deserialization.jsonapi_parse(params)
    end

    def included_relationships
      []
    end

    def create_params
      #  It should not be necessary to merge level params
      params.merge(level_params)
            .permit(
              policy(resource_class).permitted_attributes
            )
            .merge(
              user: current_user
            )
    end

    def update_params
      #  It should not be necessary to merge level params
      params.merge(level_params)
            .permit(
              policy(resource_class).permitted_attributes
            )
            .merge(
              user: current_user
            )
    end

    def find_activity
      @activity = policy_scope(resource_class).find(params[:id])
    end
  end
end
