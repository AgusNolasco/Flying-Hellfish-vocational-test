# frozen_string_literal: true

### Delete existing responses and surveys ###
Response.all.map(&:destroy)
Survey.all.map(&:destroy)
