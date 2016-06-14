module V1
  class ActivitiesController < ApiController
    # include ActivitiesHelper
    include PaginationHelper

    before_action :find_activity, only: [:show, :update, :destroy]

    def index

      @activities = policy_scope(resource_class)
      # @activities = @activities.desc(:created_at).page(page).per(per_page)

      authorize @activities

      render json: @activities
      # , meta: {
      #   page: page,
      #   per_page: per_page,
      #   total_pages: @activities.total_pages
      # }
    end

    def filter
      # binding.pry
      @activities = policy_scope(resource_class).in(@filter)

      authorize @activities
      render json: @activities
    end

    def show
      authorize @activity
      # binding.pry
      render json: @activity
    end

    def create
      # binding.pry
      @activity = policy_scope(resource_class).new level_params
      authorize @activity
      @activity.save!
      render json: @activity, status: :created
    end

    def update
      authorize @activity
      # binding.pry
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

    def create_params
      params.require(:data).permit!.merge(user: current_user) #.merge(level_params)
      # params.merge(level_params)
      # params.require(:data).require(:attributes).permit(policy(resource_class).permitted_attributes).merge(params.require(:data).require(:relationships).permit(policy(resource_class).permitted_attributes).merge(         user: current_user        )
      # params.require(:data).require(:relationships).permit([:engine, :created_at, :updated_at, :data, :goal, :type, :product_owner])
    end

    def update_params
      # params.merge(level_params)
      #   .permit(policy(resource_class).permitted_attributes)
      #   .merge(
      #     user: current_user
      #   )
      params.require(:data).permit!.merge(user: current_user)
        # Should also include
        # .require(:data)
        # .require(:attributes)
    end

    def find_activity
      @activity = policy_scope(resource_class).find(params[:id])
    end
  end
end
