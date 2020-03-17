require 'spec_helper'

describe API::V1::TestsController do
  let(:user) { create :student }
  let(:test1) { build :test }
  let(:question1) { test1.questions.build(label: 'question_1', description: 'Question 1') }
  let!(:option1) { question1.options.build(content: 'option 1', correct: true) }
  let!(:option2) { question1.options.build(content: 'option 2', correct: false) }
  let(:question2) { test1.questions.build(label: 'question_2', description: 'Question 2') }
  let!(:option3) { question2.options.build(content: 'option 3', correct: true) }
  let(:test2) { build :test }
  let(:question3) { test2.questions.build(label: 'question_3', description: 'Question 3') }
  let!(:option4) { question3.options.build(content: 'option 4', correct: true) }

  before do
    sign_in(user)
    test1.save
    test2.save
  end

  describe '#index' do
    let(:token) { @auth_token }
    subject(:do_request) { get :index, params: { auth_token: token }, format: :json }

    context 'with valid token' do
      it 'returns a list of tests' do
        do_request
        expect(json_response['tests'].collect { |e| e['id'] }).to eq Test.all.order(id: :desc).ids
      end
    end

    context 'with invalid token' do
      let(:token) { 'fake_token' }

      it 'returns invalid token' do
        do_request
        expect(json_response['success']).to be_falsey
        expect(json_response['message']).to eq I18n.t('api.v1.errors.invalid_token')
      end
    end
  end

  describe '#show' do
    let(:token) { @auth_token }
    subject(:do_request) { get :show, params: { id: test1.id, auth_token: token }, format: :json }

    context 'with valid token' do
      it 'returns a test with questions' do
        do_request
        expect(json_response['test']['id']).to eq test1.id
        expect(json_response['test']['questions'].collect { |e| e['id'] }).to eq test1.questions.ids
      end
    end

    context 'with invalid token' do
      let(:token) { 'fake_token' }

      it 'returns invalid token' do
        do_request
        expect(json_response['success']).to be_falsey
        expect(json_response['message']).to eq I18n.t('api.v1.errors.invalid_token')
      end
    end
  end

  describe '#save_answer' do
    let(:token) { @auth_token }
    subject(:do_request) { post :save_answer, params: { id: test1.id, auth_token: token }, format: :json }

    context 'with valid token' do
      it 'returns successful message' do
        do_request
        expect(json_response['success']).to be_truthy
        expect(json_response['message']).to eq I18n.t('api.v1.inform.save_answer_successful')
      end
    end

    context 'with invalid token' do
      let(:token) { 'fake_token' }

      it 'returns invalid token' do
        do_request
        expect(json_response['success']).to be_falsey
        expect(json_response['message']).to eq I18n.t('api.v1.errors.invalid_token')
      end
    end
  end
end