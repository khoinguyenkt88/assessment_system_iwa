module API
  module V1
    class SessionsController < API::V1::BaseController
      skip_before_action :authenticate_user_from_token!
      skip_before_action :authenticate_user!
      resource_description do
        name 'Authentication'
        formats ['json']
      end

      api :POST, '/authenticate', "Authenticate and obtain a token"
      description "Pass in your email and password and obtain a token to use for API calls."
      param :user, Hash, desc: 'The User', required: true do
        param :email, String, desc: 'Student email', required: true
        param :password, String, desc: 'Student password', required: true
      end
      error code: 401, desc: "Your email or password is incorrect"

      def create
        request.env['devise.allow_params_authentication'] = true
        user = warden.authenticate(scope: :user)
        if user
          raise CanCan::AccessDenied if user.is_a?(Teacher)

          sign_in(:user, user, store: false)
          user_session = user.user_sessions.create!

          respond_with user, serializer: UserSerializer
        else
          render json: generate_response(success: false, error: :invalid_credentials, message: 'Authentication failed.'), status: 401
        end
      end

      def destroy
        current_session&.destroy!
        sign_out(:current_user)
        render json: generate_response(success: true), status: 200
      end
    end
  end
end
