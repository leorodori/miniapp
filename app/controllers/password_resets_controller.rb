class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:password_reset][:email].downcase)

    if user
      user.reset_password_token = SecureRandom.urlsafe_base64
      user.reset_password_sent_at = Time.current
      user.save!(validate: false) 

      PasswordResetMailer.reset_email(user).deliver_now

      redirect_to root_path, notice: "パスワード再設定用のメールを送信しました。メールをご確認ください。"
    else
      flash.now[:alert] = "メールアドレスが見つかりませんでした。"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find_by(reset_password_token: params[:id])

    if @user.nil? || @user.reset_password_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, alert: "パスワード再設定リンクが無効であるか、期限切れです。"
    end
  end

  def update
    @user = User.find_by(reset_password_token: params[:id])

    if @user.nil? || @user.reset_password_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, alert: "パスワード再設定リンクが無効であるか、期限切れです。"
      return
    end

    if @user.update(user_params)
      @user.update(reset_password_token: nil, reset_password_sent_at: nil)
      redirect_to root_path, notice: "パスワードが正常に更新されました。新しいパスワードでログインしてください。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end