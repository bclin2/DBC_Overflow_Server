class QuestionsController < ApplicationController

  before_action :authorize_cors

  def new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      render :json => @question
    else
      @errors = @question.errors
      render :json => {
        error: @errors,
        status: 500,
      }, status: 500
    end
  end

  def index
    @questions = Question.all
    @quote = HTTParty.get(
      "https://api.github.com/zen?access_token=#{ENV['ACCESS_TOKEN']}",
      headers: {
        'User-Agent' => "#{ENV['APP_NAME']}"
      }).body

    render :json => {questions: @questions, quote: @quote}
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
    @question = Question.find(params[:id])
    @question.destroy
    head :no_content
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      render :json => @question
    else
      @errors = @question.errors
      render :json => {
        error: @errors,
        status: 500,
      }, status: 500
    end
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

  def authorize_cors
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end

end
