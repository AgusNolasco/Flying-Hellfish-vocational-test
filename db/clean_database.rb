# frozen_string_literal: true

### Delete existing dataset ###
Response.all.map(&:destroy)
Survey.all.map(&:destroy)
Outcome.all.map(&:destroy)
Career.all.map(&:destroy)
Choice.all.map(&:destroy)
Question.all.map(&:destroy)
