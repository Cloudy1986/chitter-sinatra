# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/flash'
require './lib/peep'
require './lib/user'
require './lib/comment'
require './redirect_helper'

# class for controller
class ChitterApplication < Sinatra::Base
  configure :development, :test do
    register Sinatra::Reloader
    register Sinatra::Flash
  end

  enable :sessions, :method_override

  # Route for homepage
  get '/' do
    @user = User.find(id: session[:user_id])
    erb :homepage
  end

  # Routes for viewing, adding, deleting & editing peeps
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

  delete '/peeps/:id' do
    Peep.delete(id: params['id'])
    redirect '/peeps'
  end

  get '/peeps/:id/edit' do
    redirect_logged_out_user
    @user = User.find(id: session[:user_id])
    @peep = Peep.find(id: params['id'])
    erb :'peeps/edit'
  end

  patch '/peeps/:id' do
    Peep.update(id: params['id'], message: params['message'])
    redirect '/peeps'
  end

  # Routes for viewing & adding comments
  get '/peeps/:id/comments' do
    @user = User.find(id: session[:user_id])
    @peep = Peep.find(id: params['id'])
    @comments = Comment.find(peep_id: params['id'])
    erb :'comments/index'
  end

  get '/peeps/:id/comments/new' do
    redirect_logged_out_user
    @user = User.find(id: session[:user_id])
    @peep = Peep.find(id: params['id'])
    erb :'comments/new'
  end

  post '/peeps/:id/comments/new' do
    Comment.create(text: params['comment_text'], peep_id: params['id'], user_id: session[:user_id])
    redirect "/peeps/#{params['id']}/comments"
  end

  # Routes for signing up
  get '/sign-up' do
    redirect_logged_in_user
    erb :'users/sign_up'
  end

  post '/sign-up/new' do
    user = User.create(username: params['username'], email: params['email'], password: params['password'])
    session[:user_id] = user.id
    redirect '/peeps'
  end

  # Routes for logging in
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

  # Routes for logging out
  post '/log-in/destroy' do
    session.clear
    redirect 'log-in'
  end

  post '/peeps/log-in/destroy' do
    session.clear
    redirect 'log-in'
  end

  post '/peeps/:id/log-in/destroy' do
    session.clear
    redirect 'log-in'
  end

  post '/peeps/:id/comments/log-in/destroy' do
    session.clear
    redirect 'log-in'
  end

  run! if app_file == $0
end
