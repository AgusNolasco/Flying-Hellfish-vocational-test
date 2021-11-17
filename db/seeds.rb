# frozen_string_literal: true

### Delete existing dataset ###
Response.all.map(&:destroy)
Survey.all.map(&:destroy)
Outcome.all.map(&:destroy)
Career.all.map(&:destroy)
Choice.all.map(&:destroy)
Question.all.map(&:destroy)

### Create new dataset ###
File.open('db/data/test1/questions.txt') do |file|
  file.each_line do |line|
    values = line.split(';')
    Question.create(number: values[0], description: values[1], name: values[2].strip)
  end
end

File.open('db/data/test1/choices.txt') do |file|
  file.each_line do |line|
    values = line.split(';')
    question = Question.find(number: values[0])
    Choice.create(question_id: question.id, text: values[1].strip)
  end
end

File.open('db/data/test1/careers.txt') do |file|
  file.each_line do |line|
    values = line.split(';')
    Career.create(name: values[0], ref: values[1].strip)
  end
end

File.open('db/data/test1/outcomes.txt') do |file|
  file.each_line do |line|
    values = line.split(';')
    question = Question.find(number: values[0])
    career = Career.find(name: values[2].strip)
    Outcome.create(choice_id: question.choices[values[1].to_i].id, career_id: career.id)
  end
end
