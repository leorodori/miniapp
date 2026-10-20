require 'rails_helper'

RSpec.describe Note, type: :model do
  describe 'バリデーションのテスト' do
    it '有効なノートデータの場合は保存できること' do
      note = build(:note)
      expect(note).to be_valid
    end

    it '本文がない場合は保存できないこと' do
      note = build(:note, body: nil)
      expect(note).not_to be_valid
      expect(note.errors[:body]).not_to be_empty
    end

    it '本文が300文字以内の場合は保存できること' do
      note = build(:note, body: "あ" * 300)
      expect(note).to be_valid
    end

    it '本文が301文字以上の場合は保存できないこと（文字数制限の境界値）' do
      note = build(:note, body: "あ" * 301)
      expect(note).not_to be_valid
      expect(note.errors[:body]).not_to be_empty
    end
  end
end