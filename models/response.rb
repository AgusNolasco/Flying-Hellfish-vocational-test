class Response < Sequel::Model
    many_to_one :survey
    many_to_one :question
end
