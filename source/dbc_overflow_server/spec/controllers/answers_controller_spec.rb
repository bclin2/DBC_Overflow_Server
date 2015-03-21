require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  describe "POST #create" do
    let!(:question) {FactoryGirl.create :question}
    before(:each) do
      @title = "testing answer title"
      @content = "testing answer content"
      post :create, {answer: {title: @title, content: @content}, question_id: question.id}
    end

    it "should create an Answer object in the database" do
      expect(assigns :answer).to eq Answer.last
      expect(Answer.last.id).to eq question.id
      expect(Answer.last.title).to eq @title
      expect(Answer.last.content).to eq @content
    end

    it "should return a JSON object of the answer upon success" do
      expect(response.body).to include question.id.to_s
      expect(response.body).to include @title
      expect(response.body).to include @content
    end
  end
end
