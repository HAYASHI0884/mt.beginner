class Users::SessionsController < Devise::SessionsController
  def new_guest
    user = User.guest
    sign_in user
    redirect_to pages_top_path, notice: 'ゲストユーザーとしてログインしました。'
  end
end
