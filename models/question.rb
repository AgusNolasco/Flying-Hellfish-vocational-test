require_relative 'util'

class Question < Sequel::Model
  one_to_many :choices
  one_to_many :responses

  def next
    next_id = self.id + 1
    next_question = Question.find(id: next_id)
    while next_id < Question.last.id && next_question.nil?
      next_id += 1
      next_question = Question.find(id: next_id)
    end

    return next_question
  end

  def prev
    prev_id = self.id - 1
    prev_question = Question.find(id: prev_id)
    while prev_id > Question.first.id && prev_question.nil?
      prev_id -= 1
      prev_question = Question.find(id: prev_id)
    end

    return prev_question
  end

  def get_response(survey_id)
    return Response.find(survey_id: survey_id, question_id: self.id)
  end

  def answered?(survey_id)
    return self.get_response(survey_id).exist?
  end

  def choice_selected(survey_id)
  	if self.answered?(survey_id)
    	return Choice.find(id: self.get_response(survey_id).choice_id)
    end
  end

  def first?
    return (self == Question.first)
  end

  def last?
    return (self == Question.last)
  end
end 
