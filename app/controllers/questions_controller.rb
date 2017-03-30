class QuestionsController < ApplicationController
  def new
    # we instaniate a new `Question` object because it will help us in
    # generating the form in `views/new.html.erb`. We have to make it an
    # instance variable so we can access it in the view file.
    @question = Question.new
  end

  def create
    # the line below is what's called "Strong Parameters" feautre that was added
    # to Rails starting with version 4 to help developer be more explicit about
    # the parameters that they want to allow the user to submit
    question_params = params.require(:question).permit([:title, :body])
    question = Question.new question_params
    question.save
    render json: params
  end
end
