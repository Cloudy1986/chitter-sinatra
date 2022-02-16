# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/flash'
require './lib/peep'
require './lib/user'

# class for controller
class ChitterApplication < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions
  register Sinatra::Flash

  get '/' do
    erb :homepage
  end

  get '/peeps' do
    @user = User.find(id: session[:user_id])
    p @user
    @peeps = Peep.all.reverse
    p @peeps
    erb :'peeps/index'
  end

  get '/peeps/new' do
    @user = User.find(id: session[:user_id])
    erb :'peeps/new'
  end

  post '/peeps/new' do
    Peep.create(message: params['message'], user_id: session[:user_id])
    redirect '/peeps'
  end

  get '/sign-up' do
    erb :'users/sign_up'
  end

  post '/sign-up/new' do
    user = User.create(username: params['username'], email: params['email'], password: params['password'])
    session[:user_id] = user.id
    redirect '/peeps'
  end

  get '/log-in' do
    erb :'users/log_in'
  end

  post '/log-in/new' do
    user = User.authenticate(email: params['email'], password: params['password'])
    if user
      session[:user_id] = user.id
      redirect '/peeps'
    else
      flash[:notice] = 'Please check your email or password and try again'
      redirect 'log-in'
    end
  end

  run! if app_file == $0
end
