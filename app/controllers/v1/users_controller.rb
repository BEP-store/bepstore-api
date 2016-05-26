module V1
  class UsersController < ApiController
    skip_before_action :signed_in_user, only: :create
    before_action :find_user, only: [:show, :update, :destroy]
    skip_after_action :verify_policy_scoped, only: :current

    def find
      # binding.pry
      @users = policy_scope(User).find(params[:ids])
      authorize User
      render json: @users
    end

    def show
      authorize @user
      render json: @user
    end

    def current
      authorize current_user
      render json: current_user, serializer: CurrentUserSerializer
    end

    def create
      @user = User.new permitted_attributes(User)
      authorize @user
      @user.save!
      render json: @user, status: :created
    end

    def update
      authorize @user
      @user.update! permitted_attributes(@user)
      render json: @user
    end

    private

    def find_user
      @user = policy_scope(User).find(params[:id])
    end
  end
end
