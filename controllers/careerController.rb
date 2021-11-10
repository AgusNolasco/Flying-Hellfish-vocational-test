require 'sinatra/base'

class CareerController < Sinatra::Base
  set :views, Proc.new { File.join(root, "../views") }

  get '/careers' do
    if Career.empty?
      erb :no_careers
    else
      erb :careers_index
    end
  end

  get '/careers/:id' do
    @career = Career.find(id: params[:id])
    erb :career_info
  end
end
