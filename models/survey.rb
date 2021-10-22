class Survey < Sequel::Model
	many_to_one :career
	one_to_many :responses
	
	def validate
		super
		errors.add(:username, :name => 'username can not be nil or empty') if username.nil? || username.empty?
	end

  def compute_result
    careers_count = Hash.new
    for career in Career.all
      careers_count[career.id] = 0
    end
    
    for response in self.responses
      for outcome in Choice.find(id: response.choice_id).outcomes
        careers_count[outcome.career_id] += 1
      end
    end
    
    self.update(
    	career_id: careers_count.key(careers_count.values.max),
    	completed_at: Sequel.lit('NOW()')
    )
  end

  def completed?
    return self.career.exist?
  end

  def self.count_completed
    count = 0
    Survey.all.each { |survey| count += 1 if survey.completed? }
    return count
  end
end
