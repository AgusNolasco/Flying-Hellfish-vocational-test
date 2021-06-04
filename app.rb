require './models/init.rb'

class App < Sinatra::Base
  get '/' do
    erb :landing_page
  end

  get '/hello/:name' do
    @name = params[:name]
    erb :hello_template
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

  get '/careers' do
    @careers = Career.all

    erb :careers_index
  end

  get '/careers/:id' do
    @career = Career.find(id: params[:id])
    erb :careers_template
  end

  post '/surveys' do
    data = request.body.read
    survey = Survey.new(username: params[:username])
    if survey.save
      [201, { 'Location' => "surveys/#{survey.id}" }, 'CREATED']
      if Question.first
        first_question_id = Question.first.id 
        redirect to("/questions/#{first_question_id}?survey_id=#{survey.id}")
      else
        redirect '/finish'
      end
    else
      [500, {}, 'Internal Server Error']
    end
  end

  get '/surveys' do
    survey = Survey.all.map {|surv| surv.username}
    survey
  end

  get '/questions/:id' do
  	if params[:id].to_i > Question.last.id 
      redirect "/finish/#{params[:survey_id]}"
    end
    if Question.find(id: params[:id]).nil?
    	redirect to("/questions/#{(params[:id].to_i) + 1}?survey_id=#{params[:survey_id]}")
    end
    @question = Question.find(id: params[:id])
    @survey_id = params[:survey_id]
    erb :questions_template
  end

  post '/responses/:survey_id' do
    response = Response.create(question_id: params[:question_id], choice_id: params[:choice_id], survey_id: params[:survey_id])
    if response.save
      [201, { 'Location' => "responses/#{response.id}" }, 'CREATED']
      redirect to("/questions/#{((response.question_id) + 1)}?survey_id=#{params[:survey_id]}")
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
  
  get '/finish/:survey_id' do
    @survey = Survey.find(:id => params[:survey_id])
    careersCount = Hash.new
    for c in Career.all
      careersCount[c.id] = 0
    end
    
    for r in @survey.responses
      choice = Choice.find(id: r.choice_id)
      for o in choice.outcomes
        careersCount[o.career_id] = careersCount[o.career_id] + 1
      end
    end

    max_ocurrences_career_id = careersCount.key(careersCount.values.max)
    @survey.career_id = max_ocurrences_career_id
    @career = Career.find(id: @survey.career_id)

    erb :finish_template 
  end
end
