# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

sample_user = User.find_or_create_by!(email: "sample@example.com") do |user|
  user.password = "samplepassword123"
  user.password_confirmation = "samplepassword123"
end

puts "サンプルユーザーを作成しました: #{sample_user.email}"

sample_user.folders.destroy_all
sample_user.words.destroy_all

work_folder = sample_user.folders.create!(name: "名言")
anime_folder = sample_user.folders.create!(name: "アニメ")

sample_user.words.create!([
  {
    name: "継続は力なり",
    folder: work_folder,
    pinned: true,
    created_at: 2.days.ago
  },
  {
    name: "知は力なり",
    folder: work_folder,
    pinned: false,
    created_at: 1.day.ago
  },
  {
    name: "あきらめたらそこで試合終了ですよ",
    folder: anime_folder,
    pinned: false,
    created_at: Time.current
  }
])

puts "サンプルデータを正常に追加しました！"