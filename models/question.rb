class Question < Sequel::Model
    one_to_many :choice
    one_to_many :response
end
  