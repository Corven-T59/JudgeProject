module RequestMacros
  def login_valid(user)
    post user_session_path, params: {'user[email]' => user.email, 'user[password]' => user.password}
    follow_redirect!
  end
end