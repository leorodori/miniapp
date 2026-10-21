require 'rails_helper'

RSpec.describe "Folders", type: :request do
  let(:user) { create(:user) }
  let!(:folder) { create(:folder, user: user) } 

  describe "未認証ユーザーのアクセス制御" do
    it "ログインしていない場合はログインページにリダイレクトされること" do
      get folders_path
      expect(response).to redirect_to(login_path)
    end
  end

  describe "ログイン済みユーザーの操作" do
    before do
      post login_path, params: { email: user.email, password: "password123" }
    end

    describe "GET /folders (一覧画面)" do
      it "フォルダ一覧が正常に表示されること" do
        get folders_path
        expect(response).to have_http_status(:success)
        expect(response.body).to include(folder.name)
      end
    end

    describe "POST /folders (フォルダ作成)" do
      context "有効なパラメータの場合" do
        it "新しいフォルダが作成され、リダイレクトされること" do
          expect {
            post folders_path, params: { folder: { name: "新しいフォルダ" } }
          }.to change(Folder, :count).by(1)
          
          expect(response).to have_http_status(:redirect)
        end
      end

      context "無効なパラメータの場合（名前が空など）" do
        it "フォルダが作成されないこと" do
          expect {
            post folders_path, params: { folder: { name: "" } }
          }.not_to change(Folder, :count)
          
          expect(response).to have_http_status(:unprocessable_entity).or have_http_status(:success)
        end
      end
    end

    describe "PATCH /folders/:id (フォルダ更新)" do
      it "フォルダ名が更新され、リダイレクトされること" do
        patch folder_path(folder), params: { folder: { name: "更新されたフォルダ名" } }
        expect(response).to have_http_status(:redirect)
        
        folder.reload
        expect(folder.name).to eq("更新されたフォルダ名")
      end
    end

    describe "DELETE /folders/:id (フォルダ削除)" do
      it "フォルダが削除され、リダイレクトされること" do
        expect {
          delete folder_path(folder)
        }.to change(Folder, :count).by(-1)
        
        expect(response).to have_http_status(:redirect)
      end
    end
  end
end