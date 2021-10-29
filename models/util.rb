# frozen_string_literal: true

class Object
  def exist?
    !nil?
  end
end

def redirect_question(curr_question, requested_question, survey_id)
  case requested_question
  when 'next'
    incoming_question = curr_question.next
  when 'prev'
    incoming_question = curr_question.prev
  when 'end'
    redirect "/finish/#{survey_id}"
  end
  redirect "/finish/#{survey_id}" if incoming_question.nil?
  redirect to("/questions/#{incoming_question.id}?survey_id=#{survey_id}")
end
