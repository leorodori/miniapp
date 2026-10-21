require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  let(:user) { create(:user, email: "test@example.com", password: "password123", password_confirmation: "password123") }

  describe "GET /login (ログイン画面)" do
    it "ログインページが正常に表示されること" do
      get login_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /login (ログイン処理)" do
    context "有効なメールアドレスとパスワードの場合" do
      it "ログインに成功し、words_pathにリダイレクトされること" do
        post login_path, params: { email: user.email, password: "password123" }
        
        expect(response).to redirect_to(words_path)
        expect(session[:user_id]).to eq(user.id)
      end
    end

    context "無効なパラメータの場合" do
      it "ログインに失敗し、422 Unprocessable Entityが返ること" do
        post login_path, params: { email: user.email, password: "wrong_password" }
        
        expect(response).to have_http_status(:unprocessable_entity)
        expect(session[:user_id]).to be_nil
      end
    end
  end

  describe "DELETE /logout (ログアウト処理)" do
    it "ログアウトに成功し、login_pathにリダイレクトされること" do
      post login_path, params: { email: user.email, password: "password123" }
      expect(session[:user_id]).to eq(user.id)

      delete logout_path
      expect(response).to redirect_to(login_path)
      expect(session[:user_id]).to be_nil
    end
  end

  describe "POST /guest_login (ゲストログイン)" do
    context "サンプルユーザーが存在する場合" do
      let!(:guest_user) { create(:user, email: "sample@example.com") }

      it "ゲストログインに成功し、words_pathにリダイレクトされること" do
        post guest_login_path
        expect(response).to redirect_to(words_path)
        expect(session[:user_id]).to eq(guest_user.id)
      end
    end

    context "サンプルユーザーが存在しない場合" do
      it "ログイン画面にリダイレクトされ、アラートが出ること" do
        post guest_login_path
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to include("サンプルユーザーが見つかりません")
      end
    end
  end
end