def redirect_logged_out_user
  if !session[:user_id]
    redirect '/'
  end
end

def redirect_logged_in_user
  if session[:user_id]
    redirect '/peeps'
  end
end
