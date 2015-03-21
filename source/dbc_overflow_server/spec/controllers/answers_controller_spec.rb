require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let!(:question) {FactoryGirl.create :question_with_answer}
  before(:each) do
    @first_answer = question.answers.first
    @current_votes = @first_answer.votes
  end

  describe "POST #create" do
    before(:each) do
      @title = "testing answer title"
      @content = "testing answer content"
      post :create, {answer: {title: @title, content: @content}, question_id: question.id}
    end

    it "should create an Answer object in the database" do
      expect(assigns :answer).to eq Answer.last
      expect(Answer.last.question_id).to eq question.id
      expect(Answer.last.title).to eq @title
      expect(Answer.last.content).to eq @content
    end

    it "should return a JSON object of the answer upon success" do
      expect(response.body).to include question.id.to_s
      expect(response.body).to include @title
      expect(response.body).to include @content
    end
  end

  describe "PUT #upvote" do
    it "should increment votes for the answer" do
      get :upvote, question_id: question.id, id: @first_answer.id
      expect(@first_answer.reload.votes).to eq(@current_votes + 1)
    end
  end

  describe "PUT #downvote" do
    it "should decrement votes for the answer by 1" do
      get :downvote, question_id: question.id, id: @first_answer.id
      expect(@first_answer.reload.votes).to eq(@current_votes - 1)
    end
  end

end
