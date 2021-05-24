require './models/init.rb'

class App < Sinatra::Base
  get '/' do
    erb :landing_page
  end

  get "/hello/:name" do
    @name = params[:name]
    erb :hello_template
  end

  post "/careers" do
    data = request.body.read
    career = Career.new(name: params[:name])
    if career.save
      [201, { 'Location' => "careers/#{career.id}" }, 'CREATED']
    else
      [500, {}, 'Internal Server Error']
    end
  end

  get '/careers' do
    @careers = Career.all

    erb :careers_index
  end

  get '/careers/:id' do
    career = Career.find(id: params[:id])
    "Career's name: #{career.name}"
  end

  post '/surveys' do
    data = request.body.read
    survey = Survey.new(username: params[:username])
    if survey.save
      [201, { 'Location' => "surveys/#{survey.id}" }, 'CREATED']
      redirect "/questions/1"
    else
      [500, {}, 'Internal Server Error']
    end
  end

  get '/surveys' do
    survey = Survey.all.map {|surv| surv.username}
    survey
  end

  get '/questions/:id' do
    @question = Question.find(id: params[:id])
    erb :questions_template
  end

  post '/responses' do
    response = Response.create(question_id: params[:question_id], choice_id: params[:answer], survey_id: 18)
    if response.save
      [201, { 'Location' => "responses/#{response.id}" }, 'CREATED']
      redirect "/questions/#{((response.question_id) + 1)}"
    else
      [500, {}, 'Internal Server Error']
    end
  end

  post "/posts" do
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
end
