require 'sinatra/base'
require_relative '../services/init'

class SurveyController < Sinatra::Base
  set :views, Proc.new { File.join(root, "../views") }
  use SurveyService

  post '/surveys' do
    if Question.empty?
      erb :no_question_template
    else
      username = params[:username]
      survey = SurveyService.create_survey(username)
      redirect to("/questions/#{Question.first.id}?survey_id=#{survey.id}")
    end
  end

  get '/questions/:id' do
    @question = Question.find(id: params[:id])
    @survey_id = params[:survey_id]
    erb :questions_template
  end

  post '/responses/:survey_id' do
    if params[:choice_id].nil?
      question = Question.find(id: params[:question_id])
      question = question.prev if params[:incoming_question] == 'prev'
      redirect to("/questions/#{question.id}?survey_id=#{params[:survey_id]}")
    end
    question_id = params[:question_id]
    choice_id = params[:choice_id]
    survey_id = params[:survey_id]
    response = SurveyService.respond_question(question_id, choice_id, survey_id)
    redirect SurveyService.get_question(response.question, params[:incoming_question], survey_id)
  end

  patch '/responses/:survey_id' do
    question_id = params[:question_id]
    choice_id = params[:choice_id]
    survey_id = params[:survey_id]
    response = SurveyService.update_response(question_id, choice_id, survey_id)
    redirect SurveyService.get_question(response.question, params[:incoming_question], survey_id)
  end

  get '/finish/:survey_id' do
    @survey = Survey.find(id: params[:survey_id])
    @survey.compute_result
    @career = Career.find(id: @survey.career_id)
    erb :finish_template
  end
  
  get '/surveys_info' do
    if Survey.count_completed.positive?
      @bottom_date = params[:bottom_date]
      @top_date = params[:top_date]
      @selected_career = params[:selected_career]
      @surveys_between_dates = nil
      if !@bottom_date.nil? && !@top_date.nil? && !params[:selected_career].nil?
        @surveys_between_dates = Survey.where(
          completed_at: @bottom_date..@top_date,
          career_id: Career.find(name: @selected_career).id
        ).all.count
      end
      erb :surveys_info_template
    else
      erb :no_surveys
    end
  end
end
