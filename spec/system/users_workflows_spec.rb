require 'rails_helper'

RSpec.describe "UsersWorkflow", type: :system do
  let!(:user) { create(:user, email: "test@example.com", password: "password123") }

  it "ログインしてフォルダを作成し、偉人の名言を追加・詳細確認できること" do
    visit login_path

    fill_in "メールアドレス", with: "test@example.com"
    fill_in "パスワード", with: "password123"
    click_button "ログイン"

    expect(current_path).to eq(words_path)

    visit folders_path
    fill_in "フォルダ名", with: "名言"
    click_button "作成する"
    expect(page).to have_content("名言")

    visit words_path

    click_link "新しい言葉を追加する"

    select "名言", from: "フォルダ"
    fill_in "言葉", with: "Stay hungry, stay foolish."
    fill_in "どんな言葉？", with: "スティーブ・ジョブズ"
    click_button "登録する"

    expect(page).to have_content("Stay hungry, stay foolish.")

    click_link "詳細"
    expect(page).to have_content("スティーブ・ジョブズ")
  end
end