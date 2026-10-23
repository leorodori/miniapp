require 'rails_helper'

RSpec.describe "UsersWorkflow", type: :system do
  let!(:user) { create(:user, email: "test@example.com", password: "password123") }

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

  describe "異常系の操作" do
    it "言葉の必須項目が空の場合、登録に失敗してエラーメッセージが表示されること" do
      visit login_path
      fill_in "メールアドレス", with: "test@example.com"
      fill_in "パスワード", with: "password123"
      click_button "ログイン"
      
      expect(current_path).to eq(words_path)

      click_link "新しい言葉を追加する"
      click_button "登録する"

      expect(page).to have_content("入力してください")
    end
  end

  describe "言葉の編集と削除", js: true do
    it "登録した言葉を編集および削除できること" do
      visit login_path
      fill_in "メールアドレス", with: "test@example.com"
      fill_in "パスワード", with: "password123"
      click_button "ログイン"

      visit folders_path
      fill_in "フォルダ名", with: "ライフハック"
      click_button "作成する"

      visit words_path
      click_link "新しい言葉を追加する"
      select "ライフハック", from: "フォルダ"
      fill_in "言葉", with: "継続は力なり"
      fill_in "どんな言葉？", with: "ことわざ"
      click_button "登録する"

      click_link "詳細"
      click_link "編集"
      
      fill_in "言葉", with: "継続は最大の力なり"
      click_button "更新する"

      expect(page).to have_content("継続は最大の力なり")

      accept_confirm("本当に削除しますか？") do
        click_link "削除"
      end

      expect(page).to have_current_path(words_path, ignore_query: true)
      expect(page).not_to have_content("継続は最大の力なり")
    end
  end

  describe "言葉の検索とフォルダ絞り込み", js: true do
    it "キーワード検索とサイドバーのフォルダによる絞り込みができること" do
      visit login_path
      fill_in "メールアドレス", with: "test@example.com"
      fill_in "パスワード", with: "password123"
      click_button "ログイン"

      visit folders_path
      fill_in "フォルダ名", with: "アニメ"
      click_button "作成する"

      visit folders_path
      fill_in "フォルダ名", with: "名言"
      click_button "作成する"

      visit words_path
      click_link "新しい言葉を追加する"
      select "アニメ", from: "フォルダ"
      fill_in "言葉", with: "心臓を捧げよ"
      fill_in "どんな言葉？", with: "『進撃の巨人』調査兵団の敬礼の言葉"
      click_button "登録する"

      visit words_path
      click_link "新しい言葉を追加する"
      select "名言", from: "フォルダ"
      fill_in "言葉", with: "為せば成る、為せねば成らぬ何事も"
      fill_in "どんな言葉？", with: "上杉鷹山の言葉"
      click_button "登録する"

      visit words_path
      fill_in "検索ワードを入力", with: "心臓"
      click_button "検索"

      expect(page).to have_content("心臓を捧げよ")
      expect(page).not_to have_content("為せば成る、為せねば成らぬ何事も")

      visit words_path
      click_link "名言"

      expect(page).to have_content("為せば成る、為せねば成らぬ何事も")
      expect(page).not_to have_content("心臓を捧げよ")
    end
  end
end