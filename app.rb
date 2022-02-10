require 'sinatra/base'
require 'sinatra/reloader'
require './lib/peep'

class ChitterApplication < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    erb :homepage
  end

  get '/peeps' do
    @peeps = Peep.all
    erb :index
  end

  run! if app_file == $0
end
