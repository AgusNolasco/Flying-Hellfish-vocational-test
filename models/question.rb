# frozen_string_literal: true

require_relative 'util'

class Question < Sequel::Model
  one_to_many :choices
  one_to_many :responses

  def next
    next_id = id + 1
    next_question = Question.find(id: next_id)
    while next_id < Question.last.id && next_question.nil?
      next_id += 1
      next_question = Question.find(id: next_id)
    end

    next_question
  end

  def prev
    prev_id = id - 1
    prev_question = Question.find(id: prev_id)
    while prev_id > Question.first.id && prev_question.nil?
      prev_id -= 1
      prev_question = Question.find(id: prev_id)
    end

    prev_question
  end

  def get_response(survey_id)
    Response.find(survey_id: survey_id, question_id: id)
  end

  def answered?(survey_id)
    get_response(survey_id).exist?
  end

  def choice_selected(survey_id)
    Choice.find(id: get_response(survey_id).choice_id) if answered?(survey_id)
  end

  def first?
    (self == Question.first)
  end

  def last?
    (self == Question.last)
  end
end
