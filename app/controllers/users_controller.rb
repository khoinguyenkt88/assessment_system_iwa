class UsersController < AssessmentsController
  load_and_authorize_resource

  def index
    @users = User.all
  end

  def new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path, notice: "The user was created successfully."
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @user.assign_attributes(user_params)

    if @user.save
      redirect_to users_path, notice: "The user was updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: 'The user was deleted.'
  end

  private

  def user_params
    standard_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
  end

  def standard_params
    return if params.has_key?(:user)

    params[:user] = params.dig(:teacher) || params.dig(:student)

    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
  end
end
