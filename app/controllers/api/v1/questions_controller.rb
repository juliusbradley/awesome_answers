class Api::V1::QuestionsController < Api::BaseController
  def show
    #http://localhost/3000
   @question = Question.find params[:id]
   #render json: question.to_json
  #render json: @question

   #if the format is JSON and we're using jbuilder as our templating
   #system. what file will be rendered?
   #/views/ap1/v1/questions/show.json.jbuilder

   #using render with json:question will use the Serializer for the question model

   #using render: sow or no render at all will use the corresponding view for the specified
  #  format (eg jbuilder for json)
end

def index
  @questions = Question.all.order('created_at DESC')
end

def update
end

def destroy
end

def create
 question_params = params.require(:question).permit(:title, :body)
 ## {question: {title: 'aaaa', body: 'aaaa'}}
 question = Question.new question_params
 question.user = @user

 if question.save
   head :ok
 else
   render json: {error: question.errors.full_messages.join(', ') }
 end
end

private

def authenticate_user
  @user = User.find_by_api_token params[:api_token]
  # head will send an empty HTTP response with a code that is inferred by the
  # symbol you pass as an argument to the `head` method
  head :unauthorized if @user.nil?
end

end
