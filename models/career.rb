class Career < Sequel::Model
    one_to_many :survey
    one_to_many :outcome
end
  
