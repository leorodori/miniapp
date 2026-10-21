require 'rails_helper'

RSpec.describe "UsersWorkflow", type: :system do
  let!(:user) { create(:user, email: "test@example.com", password: "password123") }

  it "ログインしてフォルダを作成できること" do
    visit login_path

    fill_in "メールアドレス", with: "test@example.com"
    fill_in "パスワード", with: "password123"
    click_button "ログイン"

    expect(current_path).to eq(words_path)

    visit folders_path

    fill_in "フォルダ名", with: "英語の勉強"
    click_button "作成する"

    expect(page).to have_content("英語の勉強")
  end
end