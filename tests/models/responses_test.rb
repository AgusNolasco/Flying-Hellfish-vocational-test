require File.expand_path '../../test_helper.rb', __FILE__

class ResponseTest < MiniTest::Unit::TestCase
  MiniTest::Unit::TestCase
  
  def test_response_may_has_question_choice_and_survey
    # Arrange
    response1 = Response.new
    response2 = Response.new
    response3 = Response.new
    response4 = Response.new
    question = Question.create(:name => 'Question1', :description => 'description1', :number => 1)
    choice = Choice.create(:text => 'choice1')
    survey = Survey.create(:username => "User1")
    # Act
    response1.question_id = question.id
    response1.choice_id   = choice.id
    
    response2.choice_id   = choice.id
    response2.survey_id   = survey.id
    
    response3.survey_id   = survey.id
    response3.question_id = question.id
    
    response4.question_id = question.id
    response4.choice_id   = choice.id
    response4.survey_id   = survey.id
    # Assert
    assert_equal(response1.valid?, false)
    assert_equal(response2.valid?, false)
    assert_equal(response3.valid?, false)
    assert_equal(response4.valid?, true)
  end
end
