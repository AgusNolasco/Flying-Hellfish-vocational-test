class Choice < Sequel::Model
    one_to_many :outcomes
    many_to_one :question
    one_to_one :response

    def validate 
        super
        errors.add(:text, :text => 'text can not be nil or empty') if text.empty? || text.nil
    end
end
