require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let!(:question) {FactoryGirl.create :question}
  let!(:answer) {FactoryGirl.create :answer}

  describe "GET #index" do
    it "should return a json of all questions" do
      get :index
      expect(response.status).to eq 200
      expect(response.body).to include question.to_json
    end
  end

  describe "GET #show" do
    it "should return a json of the question and all its answers" do
      get :show, id: question.id

      question_show = {question: { title: question.title,
                   content: question.content,
                   answers: question.answers,
      }}


      expect(response.body).to eq question_show.to_json
    end
  end

  describe "POST #create" do
    context "Valid input" do
      before(:each) do
        @title = "testing title"
        @content = "testing content"
        post :create, {question: {title: @title, content: @content}}
      end

      it "should create a Question object in the database" do
        expect(assigns :question).to eq Question.last
        expect(Question.last.title).to eq @title
        expect(Question.last.content).to eq @content
      end

      it "should return a JSON object of the question upon success" do
        expect(response.body).to include @title
        expect(response.body).to include @content
      end
    end

    context "Invalid input" do
      it "should return a status code 500 if failed to save" do
        post :create, {question: {title: "testing title, no content"}}
        expect(response.status).to eq 500
      end
    end
  end

  describe "PUT #update" do
    context "valid input" do
      before(:each) do
        @changed_title = "testing CHANGED title"
        @changed_content = "testing CHANGED content"
        put :update, {question: {title: @changed_title, content: @changed_content}, id: question.id, }
      end

      it "should update the question with appropriate changed values" do
        expect(question.reload.title).to eq(@changed_title)
        expect(question.reload.content).to eq(@changed_content)
      end

      it "should return a JSON object with newly changed content" do
        expect(response.body).to include @changed_title
        expect(response.body).to include @changed_content
      end
    end

    context "invalid input" do
      it "should return an internal server error 500" do
        @changed_content = "testing CHANGED content"
        put :update, {question: {title: "", content: ""}, id: question.id}
        expect(response.status).to eq 500
      end
    end
  end

  describe "PUT #upvote" do
    it "should increment the vote by 1 in the database" do
      current_votes = question.votes
      put :upvote, id: question.id
      expect(question.reload.votes).to eq(current_votes + 1)
    end
  end

  describe "PUT #downvote" do
    it "should increment the vote by 1 in the database" do
      current_votes = question.votes
      put :downvote, id: question.id
      expect(question.reload.votes).to eq(current_votes - 1)
    end
  end

end
