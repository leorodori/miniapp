class PasswordsController < ApplicationController
  before_action :require_login

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    # 1. 現在のパスワードが正しいか検証する（これは authenticate に直接渡すのでOK）
    if @user.authenticate(params[:user][:current_password])
      # 2. 新しいパスワードで更新する（password_params には current_password を含まない）
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
    # DBに存在しない current_password はストロングパラメータから除外する
    params.require(:user).permit(:password, :password_confirmation)
  end
end