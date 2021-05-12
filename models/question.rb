class Question < Sequel::Model
    one_to_many :choice
end
  