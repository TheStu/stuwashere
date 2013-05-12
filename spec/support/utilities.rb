def full_title(page_title) #Returns the full title on a per-page basis.
  base_title = "Stu Was Here"
  if page_title.empty?
    base_title
  elsif page_title == "home"
    "#{base_title} | Live Vicariously Through Me"
  else
    "#{page_title} | #{base_title}"
  end
end

def sign_in(user)
  visit new_user_session_path
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
  # Sign in when not using Capybara as well.
  # cookies[:remember_token] = user.remember_token
end
