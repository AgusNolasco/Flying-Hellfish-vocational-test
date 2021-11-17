# frozen_string_literal: true

class Outcome < Sequel::Model
  many_to_one :career
  many_to_one :choice

  def validate
    super
    errors.add(:career_id, name: 'career_id can not be nil') if career_id.nil? || !career_id
    errors.add(:choice_id, name: 'choice_id can not be nil') if choice_id.nil? || !choice_id
  end
end
