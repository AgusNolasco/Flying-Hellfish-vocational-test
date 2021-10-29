require './models/init.rb'

class App < Sinatra::Base
  set :method_override, true

  get '/' do
    if !params[:rejected].nil?
      @rejected = true
    end
    erb :landing_page
  end

  get '/careers' do
    if (Career.empty?)
      erb :no_careers
    else
      erb :careers_index
    end
  end

  get '/careers/:id' do
    @career = Career.find(id: params[:id])
    erb :career_info
  end

  post '/surveys' do
    if Survey.find(username: params[:username]).exist?
    	redirect '/?rejected=true'
    end
    if Question.empty?
      erb :no_question_template
    else
      survey = Survey.new(username: params[:username])
      if survey.save
        [201, { 'Location' => "surveys/#{survey.id}" }, 'CREATED']
      else
        [500, {}, 'Internal Server Error']
      end
      redirect to("/questions/#{Question.first.id}?survey_id=#{survey.id}")
    end
  end

  get '/questions/:id' do 
    @question = Question.find(id: params[:id])
    @survey_id = params[:survey_id]
    erb :questions_template
  end

  patch '/responses/:survey_id' do
    response = Response.find(survey_id: params[:survey_id], question_id: params[:question_id])
    response.update(choice_id: params[:choice_id])
    if response.save
      [201, { 'Location' => "responses/#{response.id}" }, 'UPDATED']
      #Redirect us to the next question
      case params[:incoming_question]
      when 'next'
        question = response.question.next
      when 'prev'
        question = response.question.prev
      when 'end'
        redirect "/finish/#{params[:survey_id]}"
      end
      if question.nil?
        redirect "/finish/#{params[:survey_id]}"
      end
      redirect to("/questions/#{(question.id)}?survey_id=#{params[:survey_id]}")
    else
      [500, {}, 'Internal Server Error']
    end
  end
  
  post '/responses/:survey_id' do
    if (params[:choice_id].nil?)
      question = Question.find(id: params[:question_id])
      if (params[:incoming_question] == 'prev')
        question = question.prev
      end
      redirect to("/questions/#{(question.id)}?survey_id=#{params[:survey_id]}")
    end
    
    response = Response.create(question_id: params[:question_id], choice_id: params[:choice_id], survey_id: params[:survey_id])
    if response.save
      [201, { 'Location' => "responses/#{response.id}" }, 'CREATED']
      #Redirect us to the next question
      case params[:incoming_question]
      when 'next'
        question = response.question.next
      when 'prev'
        question = response.question.prev
      when 'end'
        redirect "/finish/#{params[:survey_id]}"
      end
      if question.nil?
        redirect "/finish/#{params[:survey_id]}"
      end
      redirect to("/questions/#{(question.id)}?survey_id=#{params[:survey_id]}")
    else
      [500, {}, 'Internal Server Error']
    end
  end
  
  get '/surveys_info' do
    @survey_count = Survey.count_completed
    if (@survey_count > 0)
      @bottom_date = params[:bottom_date]
      @top_date = params[:top_date]
      @selected_career = params[:selected_career]
      @surveys_between_dates = nil
      if (!@bottom_date.nil? && !@top_date.nil? && !params[:selected_career].nil?)
        @surveys_between_dates = Survey.where(
          :completed_at => @bottom_date .. @top_date,
          :career_id => Career.find(:name => @selected_career).id
        ).all.count
      end
      erb :surveys_info_template
    else
      erb :no_surveys
    end
  end

  get '/finish/:survey_id' do
    @survey = Survey.find(:id => params[:survey_id])
    @survey.compute_result
    @career = Career.find(id: @survey.career_id)
    erb :finish_template 
  end
end
