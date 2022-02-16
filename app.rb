# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require './lib/peep'
require './lib/user'

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
    erb :'peeps/index'
  end

  get '/peeps/new' do
    erb :'peeps/new'
  end

  post '/peeps/new' do
    Peep.create(message: params['message'])
    redirect '/peeps'
  end

  get '/sign-up' do
    erb :'users/sign_up'
  end

  post '/sign-up/new' do
    User.create(username: params['username'], email: params['email'], password: params['password'])
    redirect '/peeps'
  end

  run! if app_file == $0
end
