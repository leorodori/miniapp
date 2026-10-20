# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションのテスト' do
    it '有効なユーザーデータの場合は保存できること' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'メールアドレスがない場合は保存できないこと' do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
      expect(user.errors[:email]).not_to be_empty
    end
  end

  describe 'カスタムメソッドのテスト' do
    let(:user) { create(:user) }

    describe '#guest?' do
      it 'メールアドレスが sample@example.com の場合はtrueを返すこと' do
        guest_user = build(:user, email: "sample@example.com")
        expect(guest_user.guest?).to be true
      end

      it '通常のメールアドレスの場合はfalseを返すこと' do
        expect(user.guest?).to be false
      end
    end
  end
end