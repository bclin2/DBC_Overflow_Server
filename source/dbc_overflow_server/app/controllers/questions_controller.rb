class QuestionsController < ApplicationController
  def new
  end

  def create
  end

  def index
    @questions = Question.all
    render :json => @questions
  end

  def destroy
  end

  def update
  end

end
