# frozen_string_literal: true

class Object
  def exist?
    !nil?
  end
end

def redirect_question(curr_question, requested_question, survey_id)
  case requested_question
  when 'next'
    redirect "/questions/#{curr_question.next.id}?survey_id=#{survey_id}"
  when 'prev'
    redirect "/questions/#{curr_question.prev.id}?survey_id=#{survey_id}"
  when 'end'
    redirect "/finish/#{survey_id}"
  end
end
