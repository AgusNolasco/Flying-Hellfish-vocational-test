# frozen_string_literal: true

require File.expand_path '../test_helper.rb', __dir__

class SurveyTest < MiniTest::Unit::TestCase
  MiniTest::Unit::TestCase
  def test_survey_must_has_username
    # Arrange
    survey1 = Survey.new
    survey2 = Survey.new
    survey3 = Survey.new
    # Act
    survey1.username = nil
    survey2.username = ''
    # Assert
    assert_equal(survey1.valid?, false)
    assert_equal(survey2.valid?, false)
    assert_equal(survey3.valid?, false)
  end
end
