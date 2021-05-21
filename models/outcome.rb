class Outcome < Sequel::Model
	many_to_one :career
	many_to_one :choice
	
	def validate
		super
		errors.add(:career_id, :name => 'career_id can not be nil') if not (career_id) or (career_id == nil)
		errors.add(:choice_id, :name => 'choice_id can not be nil') if not (choice_id) or (choice_id == nil)
	end
end
