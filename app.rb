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

  def logged_out_user
    if !session[:user_id]
      redirect '/'
    end
  end

  def logged_in_user
    if session[:user_id]
      redirect '/peeps'
    end
  end

  get '/' do
    @user = User.find(id: session[:user_id])
    erb :homepage
  end

  get '/peeps' do
    @user = User.find(id: session[:user_id])
    @peeps = Peep.all
    erb :'peeps/index'
  end

  get '/peeps/new' do
    logged_out_user
    @user = User.find(id: session[:user_id])
    erb :'peeps/new'
  end

  post '/peeps/new' do
    Peep.create(message: params['message'], user_id: session[:user_id])
    redirect '/peeps'
  end

  get '/sign-up' do
    logged_in_user
    erb :'users/sign_up'
  end

  post '/sign-up/new' do
    user = User.create(username: params['username'], email: params['email'], password: params['password'])
    session[:user_id] = user.id
    redirect '/peeps'
  end

  get '/log-in' do
    logged_in_user
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

  post '/log-in/destroy' do
    session.clear
    redirect 'log-in'
  end

  run! if app_file == $0
end
