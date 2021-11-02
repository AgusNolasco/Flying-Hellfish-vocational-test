# frozen_string_literal: true

class Career < Sequel::Model
  one_to_many :surveys
  one_to_many :outcomes

  def validate
    super
    errors.add(:name, name: 'name can not be nil or empty') if name.nil? || name.empty?
  end

  def self.empty?
    Career.all.count.zero?
  end
end
