require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  describe "GET #index" do
    let!(:question) {FactoryGirl.create :question}
    it "should return a json of all questions" do
      get :index
      expect(response.status).to eq 200
      expect(response.body).to include question.to_json
    end
  end

  describe "GET #show" do

  end

end
