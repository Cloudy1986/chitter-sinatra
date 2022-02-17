# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/flash'
require './lib/peep'
require './lib/user'
require './redirect_helper'

# class for controller
class ChitterApplication < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions, :method_override
  register Sinatra::Flash

  get '/' do
    @user = User.find(id: session[:user_id])
    erb :homepage
  end

  get '/peeps' do
    @user = User.find(id: session[:user_id])
    @peeps = Peep.all.sort_by(&:created_at).reverse
    erb :'peeps/index'
  end

  get '/peeps/new' do
    redirect_logged_out_user
    @user = User.find(id: session[:user_id])
    erb :'peeps/new'
  end

  post '/peeps/new' do
    Peep.create(message: params['message'], user_id: session[:user_id])
    redirect '/peeps'
  end

  get '/sign-up' do
    redirect_logged_in_user
    erb :'users/sign_up'
  end

  post '/sign-up/new' do
    user = User.create(username: params['username'], email: params['email'], password: params['password'])
    session[:user_id] = user.id
    redirect '/peeps'
  end

  get '/log-in' do
    redirect_logged_in_user
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

  delete '/peeps/:id' do
    Peep.delete(id: params['id'])
    redirect '/peeps'
  end

  run! if app_file == $0
end
