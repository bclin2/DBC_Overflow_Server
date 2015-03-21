class AnswersController < ApplicationController
  def new
  end

  def create
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

  def upvote
    @answer = Answer.find(params[:id])
    @answer.votes += 1
    @answer.save
    head 200
  end

  def downvote
    @answer = Answer.find(params[:id])
    @answer.votes -= 1
    @answer.save
    head 200
  end


end
