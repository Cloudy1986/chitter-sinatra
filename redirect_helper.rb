# frozen_string_literal: true

def redirect_logged_out_user
  return if session[:user_id]

  redirect '/'
end

def redirect_logged_in_user
  return unless session[:user_id]

  redirect '/peeps'
end
