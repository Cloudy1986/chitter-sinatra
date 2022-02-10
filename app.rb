require 'sinatra/base'
require 'sinatra/reloader'

class ChitterApplication < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    erb :homepage
  end

  get '/peeps' do
    @peeps = [
      "I'm learning to code and practising building a web app",
      "Ruby is the best!",
      "I'm loving using Sinatra to build a web app"
    ]
    erb :index
  end

  run! if app_file == $0
end
