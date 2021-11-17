# frozen_string_literal: true

require './models/init'
require './controllers/init'

class App < Sinatra::Base
  use SurveyController
  use CareerController

  set :method_override, true

  get '/' do
    erb :landing_page
  end
end
