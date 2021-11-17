# frozen_string_literal: true

require File.expand_path '../test_helper.rb', __dir__

class CareerTest < MiniTest::Unit::TestCase
  MiniTest::Unit::TestCase

  def test_career_may_has_many_surveys
    # Arrange
    career = Career.create(name: 'Ing. Mecanica')
    # Act
    Survey.create(username: 'User1', career_id: career.id)
    Survey.create(username: 'User2', career_id: career.id)
    Survey.create(username: 'User3', career_id: career.id)
    # Assert
    assert_equal(career.surveys.count, 3)
  end

  def test_career_must_has_name
    # Arrange
    career1 = Career.new
    career2 = Career.new
    career3 = Career.new
    career4 = Career.new
    # Act
    career1.name = nil
    career2.name = ''
    career4.name = 'Lic. en Biologia'

    # Assert
    assert_equal(career1.valid?, false)
    assert_equal(career2.valid?, false)
    assert_equal(career3.valid?, false)
    assert_equal(career4.valid?, true)
  end
end
