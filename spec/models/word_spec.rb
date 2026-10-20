require 'rails_helper'

RSpec.describe Word, type: :model do
  describe 'バリデーションのテスト' do
    it '有効な単語データの場合は保存できること' do
      word = build(:word)
      expect(word).to be_valid
    end

    it '単語名がない場合は保存できないこと' do
      word = build(:word, name: nil)
      expect(word).not_to be_valid
      expect(word.errors[:name]).not_to be_empty
    end

    it '単語名が100文字以内の場合は保存できること' do
      word = build(:word, name: "あ" * 100)
      expect(word).to be_valid
    end

    it '単語名が101文字以上の場合は保存できないこと（文字数制限の境界値）' do
      word = build(:word, name: "あ" * 101)
      expect(word).not_to be_valid
      expect(word.errors[:name]).not_to be_empty
    end
  end

  describe 'カスタムメソッドのテスト' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:word) { create(:word, user: user) }

    describe '#owned_by?' do
      it '単語の所有者の場合はtrueを返すこと' do
        expect(word.owned_by?(user)).to be true
      end

      it '単語の所有者ではない場合はfalseを返すこと' do
        expect(word.owned_by?(other_user)).to be false
      end
    end
  end
end