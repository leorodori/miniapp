require 'rails_helper'

RSpec.describe "UsersWorkflow", type: :system do
  let!(:user) { create(:user, email: "test@example.com", password: "password123") }

  # 1. 正常系（ログイン〜フォルダ作成〜言葉追加〜詳細確認）
  it "ログインしてフォルダを作成し、言葉を追加・詳細確認できること" do
    visit login_path
    fill_in "メールアドレス", with: "test@example.com"
    fill_in "パスワード", with: "password123"
    click_button "ログイン"

    expect(current_path).to eq(words_path)

    visit folders_path
    fill_in "フォルダ名", with: "人生の教訓"
    click_button "作成する"
    expect(page).to have_content("人生の教訓")

    visit words_path
    click_link "新しい言葉を追加する"

    select "人生の教訓", from: "フォルダ"
    fill_in "言葉", with: "Stay hungry, stay foolish."
    fill_in "どんな言葉？", with: "スティーブ・ジョブズ"
    click_button "登録する"

    expect(page).to have_content("Stay hungry, stay foolish.")
    click_link "詳細"
    expect(page).to have_content("スティーブ・ジョブズ")
  end

  # 2. 異常系（バリデーションエラーの検証）
  describe "異常系の操作" do
    it "言葉の必須項目が空の場合、登録に失敗してエラーメッセージが表示されること" do
      visit login_path
      fill_in "メールアドレス", with: "test@example.com"
      fill_in "パスワード", with: "password123"
      click_button "ログイン"
      
      expect(current_path).to eq(words_path)

      click_link "新しい言葉を追加する"

      # 何も入力せずに「登録する」ボタンを押す
      click_button "登録する"

      # バリデーションエラーメッセージが表示されていることを確認
      expect(page).to have_content("入力してください")
    end
  end
end