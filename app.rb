# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require './lib/peep'

# class for controller
class ChitterApplication < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    erb :homepage
  end

  get '/peeps' do
    @peeps = Peep.all.reverse
    if @peeps != []
      p @peeps[0].created_at
    end
    erb :index
  end

  get '/peeps/new' do
    erb :new
  end

  post '/peeps/new' do
    Peep.create(message: params['message'])
    redirect '/peeps'
  end

  run! if app_file == $0
end
