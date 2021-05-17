class Choice < Sequel::Model
    one_to_many :outcome
    many_to_one :question
    one_to_one :response
end
