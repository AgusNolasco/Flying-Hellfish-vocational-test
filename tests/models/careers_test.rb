require File.expand_path '../../test_helper.rb', __FILE__

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
=begin
  def test_survey_has_a_career
    # Arrange
    survey = Survey.new
    # Act
    survey.career_id = nil
    # Assert
    assert_equal survey.valid?, false 
  end
=end
end
