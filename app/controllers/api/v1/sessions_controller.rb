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
      example "curl -d 'user[email]=student2@example.com&user[password]=12345678' -X POST http://assessments-iwa-test.herokuapp.com/api/v1/authenticate"
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
          render json: generate_response(false, t('api.v1.errors.authentication_failed'), :invalid_credentials), status: 401
        end
      end

      api :DELETE, '/authenticate', "Logout"
      description "Destroy session and logout student"
      param :auth_token, String, desc: 'Token key', required: true
      example 'curl -X DELETE http://assessments-iwa-test.herokuapp.com/api/v1/authenticate?auth_token=XXXXXXX'
      error code: 403, desc: "Invalid token"
      def destroy
        if current_session
          current_session.destroy!
          sign_out(:current_user)
          render json: generate_response(true, t('api.v1.inform.logged_out')), status: 200
        else
          render json: generate_response(false, t('api.v1.errors.invalid_token', :invalid_token)), status: 403
        end
      end
    end
  end
end
