class AssessmentsController < ApplicationController
  before_action :authenticate_user!
  layout 'assessments'

  EXCEPTIONS = [
    ActionController::InvalidAuthenticityToken,
    CanCan::AccessDenied
  ].freeze

  rescue_from *EXCEPTIONS do |exception|
    sign_out
    redirect_to new_user_session_path, notice: exception.message
  end

  def index
    redirect_to users_path
  end
end