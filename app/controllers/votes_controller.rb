class VotesController < ApplicationController
before_action :authenticate_user!
  # TODO: build and enforce permissions for the actions in this controller
# {
#   "_method": "post",
#   "authenticity_token": "Q6aIc/AJSqiIWiRnQGs3jv+4BUnGRO/XpiE67WGntxPQywgLvgXMkOaSBq6W9TTJ7grQSe0mew7vdvyEx36xZA==",
#   "is_up": "false",
#   "controller": "votes",
#   "action": "create",
#   "question_id": "1999"
# }

def create
  question = Question.find params[:question_id]
  vote     = Vote.new is_up: params[:is_up],
                      user: current_user,
                      question: question
  if vote.save
    # using `redirec_to question` is the same as doing:
    # redirec_to question_path(question)
    redirect_to question, notice: 'vote recieved!'
  else
    redirect_to question, alert: vote.errors.full_messages.join(', ')
  end
end

def destroy
 vote = Vote.find params[:id]
 vote.destroy
redirect_to question_path(vote.question), notice: 'unvoted!'
end

def update
  vote = Vote.find params[:id]
  vote.is_up = params[:is_up]
  if vote.save
    redirect_to vote.question, notice: 'Vote changed'
  else
    redirect_to vote.question, alert: vote.errors.full_messages.join(', ')
end
end
end
