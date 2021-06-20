class Question < Sequel::Model
  one_to_many :choices
  one_to_many :responses

  def next
    next_id = self.id + 1
    next_question = Question.find(id: next_id)
    while next_id < Question.last.id and next_question.nil?
      next_id += 1
      next_question = Question.find(id: next_id)
    end

    return next_question
  end

  def back
    prev_id = self.id - 1
    prev_question = Question.find(id: prev_id)
    while prev_id > Question.first.id and prev_question.nil?
      prev_id -= 1
      prev_question = Question.find(id: prev_id)
    end

    return prev_question
  end

end 
