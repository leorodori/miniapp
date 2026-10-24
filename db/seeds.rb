sample_user = User.find_or_create_by!(email: "sample@example.com") do |user|
  user.password = "samplepassword123"
  user.password_confirmation = "samplepassword123"
end

puts "サンプルユーザーを作成しました: #{sample_user.email}"

sample_user.folders.destroy_all
sample_user.words.destroy_all

work_folder = sample_user.folders.create!(name: "名言")
anime_folder = sample_user.folders.create!(name: "アニメ")

word1 = sample_user.words.create!(
  name: "継続は力なり",
  description: "毎日コツコツと努力を積み重ねることが、最終的に大きな成果を生むという教え。",
  folder: work_folder,
  pinned: true,
  created_at: 2.days.ago
)
word1.notes.create!([
  { body: "毎日少しずつでも続けることで、大きな成果につながることを実感した。", created_at: 4.days.ago },
  { body: "最初は面倒くさくても、習慣化してしまえばこっちのもの。", created_at: 1.day.ago }
])

word2 = sample_user.words.create!(
  name: "知は力なり",
  description: "フランシス・ベーコンの名言。学ぶことで視野が広がり、困難を切り抜ける力になる。",
  folder: work_folder,
  pinned: false,
  created_at: 1.day.ago
)
word2.notes.create!([
  { body: "新しい知識を得るたびに、自分の選択肢が増えている感覚がある。", created_at: 1.day.ago }
])

word3 = sample_user.words.create!(
  name: "あきらめたらそこで試合終了ですよ",
  description: "『スラムダンク』安西先生の言葉。人生のバイブル。",
  folder: anime_folder,
  pinned: false,
  created_at: Time.current
)
word3.notes.create!([
  { body: "今日からハードな1週間。この言葉を思い出して乗り越えよう。", created_at: Time.current },
  { body: "諦めないことで、思わぬ逆転のチャンスが生まれると信じたい。", created_at: Time.current }
])

puts "サンプルデータを正常に追加しました！"