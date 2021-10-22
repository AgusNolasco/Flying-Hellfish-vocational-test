class Survey < Sequel::Model
	many_to_one :career
	one_to_many :responses
	
	def validate
		super
		errors.add(:username, :name => 'username can not be nil or empty') if username.nil? || username.empty?
	end

  def compute_result
    #Use a HashMap to index the careers
    careers_count = Hash.new
    for c in Career.all
      careers_count[c.id] = 0
    end
    
    for r in self.responses
      choice = Choice.find(id: r.choice_id)
      for o in choice.outcomes
        careers_count[o.career_id] += 1
      end
    end
    
    max_ocurrences_career_id = careers_count.key(careers_count.values.max)
    self.update(career_id: max_ocurrences_career_id) 
    self.update(completed_at: Sequel.lit('NOW()'))
  end

  def completed?
    return (!self.career.nil?)
  end

  def self.count_completed
    sum = 0
    for s in Survey.all
      if (s.completed?)
        sum += 1
      end
    end
    return sum
  end
end
