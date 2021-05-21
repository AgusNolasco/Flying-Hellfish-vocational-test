class Response < Sequel::Model
  many_to_one :survey
  many_to_one :question
  one_to_one  :choice
  def validate
    super
    errors.add(:question_id, :name => 'question_id can not be nil') if (question_id.nil?) || (not (question_id))
    errors.add(:choice_id,   :name => 'choice_id can not be nil')   if (choice_id.nil?) || (not (choice_id)) 
    errors.add(:survey_id,   :name => 'survey_id can not be nil')   if (survey_id.nil?) || (not (survey_id)) 
  end
end
