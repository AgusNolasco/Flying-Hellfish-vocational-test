class Choice < Sequel::Model
    one_to_many :outcomes
    many_to_one :question
    one_to_one :response
end
