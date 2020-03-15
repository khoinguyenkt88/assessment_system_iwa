module API
  module V1
    class BaseController < ApplicationController
      protect_from_forgery with: :null_session
      before_action :authenticate_user_from_token!
      before_action :authenticate_user!
      serialization_scope :current_user

      resource_description do
        api_version "1.0"
      end

      respond_to :json

      rescue_from CanCan::AccessDenied do |exception|
        render json: generate_response(success: false, message: exception.message)
      end

      def current_session
        session_token = params[:auth_token]
        session_token.present? && UserSession.find_by(token: session_token)
      end

      private

      def authenticate_user_from_token!
        if current_session
          current_session.touch
          bypass_sign_in(current_session.user)
        else
          render json: { success: false, error: :invalid_token, message: 'Invalid token.' }, status: 403
        end
      end

      def generate_response params = {}
        { success: params[:success], error: params[:error], message: params[:message] }
      end
    end
  end
end