class PasswordsController < ApplicationController
  before_action :require_login
  before_action :check_guest, only: [:update]

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.authenticate(params[:user][:current_password])
      if @user.update(password_params)
        redirect_to root_path, notice: "パスワードを変更しました。"
      else
        render :edit, status: :unprocessable_entity
      end
    else
      @user.errors.add(:current_password, "が間違っています。")
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end