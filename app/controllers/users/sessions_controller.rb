class Users::SessionsController < Devise::SessionsController
  def guest_sign_in
    user = User.guest
    p "guest_sign_in"
    p user
    sign_in user
    redirect_to user_path(user), notice: "guestuserでログインしました。"
  end
end
