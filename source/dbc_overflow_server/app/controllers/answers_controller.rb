class AnswersController < ApplicationController
  def new
  end

  def create
    p params
    p params[:answer]
    p params[:answer][:title]
    p params[:question_id]
    @question = Question.find(params[:question_id])
    @answer = Answer.new(title: params[:answer][:title], content: params[:answer][:content], question_id: @question.id)
    if @answer.save
      render :json => @answer
    else
      @errors = @answer.errors
      render :json => {
        errors: @errors,
        status: 500,
      }, status: 500
    end
  end
end
