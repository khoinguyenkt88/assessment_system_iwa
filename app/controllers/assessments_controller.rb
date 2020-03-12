class AssessmentsController < ApplicationController
  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    sign_out
    redirect_to new_user_session_path, notice: exception.message
  end
end