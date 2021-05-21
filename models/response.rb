class Response < Sequel::Model
  many_to_one :survey
  many_to_one :question
  one_to_one  :choice
  def validate
    super
    errors.add(:question_id, :name => 'question_id can not be nil') if not (question_id) || (question_id.nil?)
    errors.add(:choice_id,   :name => 'choice_id can not be nil')   if not (choice_id)   || (choice_id.nil?)
    errors.add(:survey_id,   :name => 'survey_id can not be nil')   if not (survey_id)   || (survey_id.nil?)
  end
end
