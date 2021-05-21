class Career < Sequel::Model
    one_to_many :surveys
    one_to_many :outcomes
    
    def validate 
      super
      errors.add(:name, :name => 'name can not be nil or empty') if not name or name.empty? or (name == nil)
    end
end
  
