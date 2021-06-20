require './models/init.rb'

class App < Sinatra::Base

  get '/' do
    erb :landing_page
  end

  post '/careers' do
    data = request.body.read
    career = Career.new(name: params[:name])
    if career.save
      [201, { 'Location' => "careers/#{career.id}" }, 'CREATED']
    else
      [500, {}, 'Internal Server Error']
    end
  end

  #Show all the careers
  get '/careers' do
    @careers = Career.all
    erb :careers_index
  end

  #Show information about a determined career (by id)
  get '/careers/:id' do
    @career = Career.find(id: params[:id])
    erb :careers_template
  end

  post '/surveys' do
    data = request.body.read
    survey = Survey.new(username: params[:username])
    if Question.first #if we have at least one question
      if survey.save
        [201, { 'Location' => "surveys/#{survey.id}" }, 'CREATED']
      else
        [500, {}, 'Internal Server Error']
      end
      first_question_id = Question.first.id 
      #Redirect us to the first question
      redirect to("/questions/#{first_question_id}?survey_id=#{survey.id}")
    else
      #if we have no questions then finish
      redirect '/finish'
    end
  end

  get '/questions/:id' do 
    @question = Question.find(id: params[:id])
    @survey_id = params[:survey_id]
    erb :questions_template
  end

  post '/responses/:survey_id' do
    response = Response.create(question_id: params[:question_id], choice_id: params[:choice_id], survey_id: params[:survey_id])
    if response.save
      [201, { 'Location' => "responses/#{response.id}" }, 'CREATED']
      #Redirect us to the next question
      next_question = response.question.next
      if next_question.nil?
        redirect "/finish/#{params[:survey_id]}"
      end
      redirect to("/questions/#{(next_question.id)}?survey_id=#{params[:survey_id]}")
    else
      [500, {}, 'Internal Server Error']
    end
  end

  post '/posts' do
    request.body.rewind  # in case someone already read it
    data = JSON.parse request.body.read
    post = Post.new(description: data['desc'])
    if post.save
      [201, { 'Location' => "posts/#{post.id}" }, 'CREATED']
    else
      [500, {}, 'Internal Server Error']
    end
  end

  get '/posts' do
    p = Post.where(id: 1).last
    p.description
  end

  #This is executed when there are no questions
  get '/finish' do
    erb :no_question_template
  end

  get '/finish/:survey_id' do
    @survey = Survey.find(:id => params[:survey_id])
    @survey.compute_result
    @career = Career.find(id: @survey.career_id)
    erb :finish_template 
  end
end
