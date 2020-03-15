module API
  module V1
    class TestsController < API::V1::BaseController
      def_param_group :test do
        property :test, Hash, desc: 'The test' do
          property :name, String, desc: 'Name of test'
          property :description, String, desc: 'Description of test'
          property :questions_count, Integer, desc: 'Number of questions'
        end
      end

      def_param_group :test_with_questions do
        property :test, Hash, desc: 'The test' do
          property :name, String, desc: 'Name of test'
          property :description, String, desc: 'Description of test'
          property :questions_count, Integer, desc: 'Number of questions'
          property :questions, array_of: Hash, desc: 'List of questions' do
            property :label, String, desc: 'Label of question'
            property :description, String, desc: 'Description of question'
          end
        end
      end

      api :GET, '/tests', 'List of Tests'
      description "Return a list of Tests"
      param :auth_token, String, desc: "Token obtained from /authenticate", required: true
      example 'curl http://assessments-iwa-test.herokuapp.com/api/v1/tests?auth_token=XXXXXXX'
      returns array_of: :test, code: 200, desc: 'All tests'
      error code: 401, desc: "Unauthorized"
      def index
        render json: Test.all.order(id: :desc), each_serializer: TestSerializer
      end

      api :GET, '/tests/:id', 'Show test'
      description "Return a test with questions"
      param :auth_token, String, desc: "Token obtained from /authenticate", required: true
      example 'curl http://assessments-iwa-test.herokuapp.com/api/v1/tests/1?auth_token=XXXXXXX'
      returns :test_with_questions, code: 200, desc: 'Show test with questions'
      error code: 401, desc: "Unauthorized"
      def show
        respond_with Test.find_by(id: params[:id]), serializer: FatTestSerializer
      end

      api :POST, '/tests/:id/save_answer', 'Save test answers'
      description "Save the student answers"
      param :auth_token, String, desc: "Token obtained from /authenticate", required: true
      example 'curl -X POST http://assessments-iwa-test.herokuapp.com/api/v1/tests/1/save_anwser?auth_token=XXXXXXX'
      returns code: 200, desc: 'Save answers successfully' do
        property :success, [true, false], desc: 'True'
        property :message, String, desc: 'Your test answers was saved successfully.'
      end
      error code: 401, desc: "Unauthorized"
      def save_answer
        render json: { success: true, message: 'Your test answers was saved successfully.' }
      end
    end
  end
end