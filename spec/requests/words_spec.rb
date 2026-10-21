require 'rails_helper'

RSpec.describe "Words", type: :request do
  let(:user) { create(:user) }
  let(:folder) { create(:folder, user: user) }
  let!(:word) { create(:word, user: user, folder: folder) }

  describe "未認証ユーザーのアクセス制御" do
    it "ログインしていない場合はログインページにリダイレクトされること" do
      get words_path
      expect(response).to redirect_to(login_path)
    end
  end

  describe "ログイン済みユーザーの操作" do
    before do
      post login_path, params: { email: user.email, password: "password123" }
    end

    describe "GET /words (一覧画面)" do
      it "単語一覧が正常に表示されること" do
        get words_path
        expect(response).to have_http_status(:success)
        expect(response.body).to include(word.name)
      end
    end

    describe "GET /words/:id (詳細画面)" do
      it "単語の詳細画面が正常に表示されること" do
        get word_path(word)
        expect(response).to have_http_status(:success)
        expect(response.body).to include(word.name)
      end
    end

    describe "POST /words (単語作成)" do
      context "有効なパラメータの場合" do
        it "新しい単語が作成され、リダイレクトされること" do
          expect {
            # body -> description に修正
            post words_path, params: { word: { name: "Test Word", description: "Test Description", folder_id: folder.id } }
          }.to change(Word, :count).by(1)
          
          expect(response).to have_http_status(:redirect)
        end
      end

      context "無効なパラメータの場合" do
        it "単語が作成されないこと" do
          expect {
            post words_path, params: { word: { name: "", description: "", folder_id: folder.id } }
          }.not_to change(Word, :count)
          
          expect(response).to have_http_status(:unprocessable_content).or have_http_status(:success)
        end
      end
    end

    describe "PATCH /words/:id (単語更新)" do
      it "単語が更新され、リダイレクトされること" do
        patch word_path(word), params: { word: { name: "Updated Name" } }
        expect(response).to have_http_status(:redirect)
        
        word.reload
        expect(word.name).to eq("Updated Name")
      end
    end

    describe "DELETE /words/:id (単語削除)" do
      it "単語が削除され、リダイレクトされること" do
        expect {
          delete word_path(word)
        }.to change(Word, :count).by(-1)
        
        expect(response).to have_http_status(:redirect)
      end
    end

    describe "ピン留め機能 (pin / unpin)" do
      it "ピン留めと解除が正常に行えること" do
        patch pin_word_path(word)
        expect(response).to have_http_status(:redirect)

        patch unpin_word_path(word)
        expect(response).to have_http_status(:redirect)
      end
    end
  end
end