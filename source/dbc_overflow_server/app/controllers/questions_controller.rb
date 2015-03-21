class QuestionsController < ApplicationController
  def new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      render :json => @question
    else
      @errors = @question.errors
      # render(:file => File.join(Rails.root, 'public/500.html'), :status => 403, :layout => false)
      render :json => {
        error: @errors,
        status: 500,
      }, status: 500
    end
  end

  def index
    @questions = Question.all
    render :json => @questions
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers
    render :json => {question: { title: @question.title,
                                 content: @question.content,
                                 answers: @answers,

      }}
  end

  def destroy
  end

  def update
  end

  def upvote
    @question = Question.find(params[:id])
    @question.votes += 1
    @question.save
    head 200
  end

  def downvote
    @question = Question.find(params[:id])
    @question.votes -= 1
    @question.save
    head 200
  end

private
  def question_params
    params.require(:question).permit(:title, :content)
  end

end
