require 'rails_helper'

RSpec.describe "Notes", type: :request do
  let(:user) { create(:user) }
  let(:folder) { create(:folder, user: user) }
  let(:word) { create(:word, user: user, folder: folder) }
  let!(:note) { create(:note, word: word) }

  describe "未認証ユーザーのアクセス制御" do
    it "ログインしていない場合はログインページにリダイレクトされること" do
      get new_word_note_path(word)
      expect(response).to redirect_to(login_path)
    end
  end

  describe "ログイン済みユーザーの操作" do
    before do
      post login_path, params: { email: user.email, password: "password123" }
    end

    describe "GET /words/:word_id/notes/new (ノート作成画面)" do
      it "ノート作成画面が正常に表示されること" do
        get new_word_note_path(word)
        expect(response).to have_http_status(:success)
      end
    end

    describe "POST /words/:word_id/notes (ノート作成)" do
      context "有効なパラメータの場合" do
        it "新しいノートが作成され、リダイレクトされること" do
          expect {
            post word_notes_path(word), params: { note: { body: "テストノートの本文" } }
          }.to change(Note, :count).by(1)
          
          expect(response).to have_http_status(:redirect)
        end
      end

      context "無効なパラメータの場合（bodyが空）" do
        it "ノートが作成されないこと" do
          expect {
            post word_notes_path(word), params: { note: { body: "" } }
          }.not_to change(Note, :count)
          
          expect(response).to have_http_status(:unprocessable_content).or have_http_status(:success)
        end
      end
    end

    describe "PATCH /words/:word_id/notes/:id (ノート更新)" do
      it "ノートが更新され、リダイレクトされること" do
        patch word_note_path(word, note), params: { note: { body: "更新されたノートの本文" } }
        expect(response).to have_http_status(:redirect)
        
        note.reload
        expect(note.body).to eq("更新されたノートの本文")
      end
    end

    describe "DELETE /words/:word_id/notes/:id (ノート削除)" do
      it "ノートが削除され、リダイレクトされること" do
        expect {
          delete word_note_path(word, note)
        }.to change(Note, :count).by(-1)
        
        expect(response).to have_http_status(:redirect)
      end
    end
  end
end