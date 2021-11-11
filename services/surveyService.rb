require 'sinatra/base'

class SurveyService < Sinatra::Base
  def self.create_survey(username)
    survey = Survey.find(username: username)
    survey = Survey.new(username: username) unless survey.exist?
    if survey.save
      [201, { 'Location' => "surveys/#{survey.id}" }, 'CREATED']
    else
      [500, {}, 'Internal Server Error']
    end
    survey
  end

  def self.respond_question(question_id, choice_id, survey_id)
    response = Response.create(question_id: question_id, choice_id: choice_id,
                               survey_id: survey_id)
    if response.save
      [201, { 'Location' => "responses/#{response.id}" }, 'CREATED']
    else
      [500, {}, 'Internal Server Error']
    end
    response
  end

  def self.update_response(question_id, choice_id, survey_id)
    response = Response.find(survey_id: survey_id, question_id: question_id)
    response.update(choice_id: choice_id)
    if response.save
      [201, { 'Location' => "responses/#{response.id}" }, 'UPDATED']
    else
      [500, {}, 'Internal Server Error']
    end
    response
  end

  def self.get_question(curr_question, requested_question, survey_id)
    case requested_question
    when 'next'
      "/questions/#{curr_question.next.id}?survey_id=#{survey_id}"
    when 'prev'
      "/questions/#{curr_question.prev.id}?survey_id=#{survey_id}"
    when 'end'
      "/finish/#{survey_id}"
    end
  end
end
