require File.expand_path '../../test_helper.rb', __FILE__

class OutcomeTest < MiniTest::Unit::TestCase
  MiniTest::Unit::TestCase
  def test_outcome_must_has_career_and_choice
    # Arrange
    outcome1 = Outcome.new
    outcome2 = Outcome.new
    outcome3 = Outcome.new
    career = Career.create(:name => 'Tecnico Nuclear')
    choice = Choice.create(:text => 'Venus del Nilo de jalea')
    # Act
    outcome1.career_id = 1
    outcome2.choice_id = 1
    outcome3.career_id = 1
    outcome3.choice_id = 1
    # Assert
    assert_equal(outcome1.valid?, false)
    assert_equal(outcome2.valid?, false)
    assert_equal(outcome3.valid?, true)
  end
end
