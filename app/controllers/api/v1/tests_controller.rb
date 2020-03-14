module API
  module V1
    class TestsController < API::V1::BaseController
      param :auth_token, String, desc: "Token obtained from /authorize", required: true
      error code: 401, desc: "Unauthorized"
      def index
        render json: Test.all.order(id: :desc), each_serializer: TestSerializer
      end

      def show
        respond_with Test.find_by(id: params[:id]), serializer: FatTestSerializer
      end

      def save_answer
        render json: { success: true, message: 'Your test answer was saved successfully.' }
      end
    end
  end
end