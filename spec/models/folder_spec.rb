require 'rails_helper'

RSpec.describe Folder, type: :model do
  describe 'バリデーションのテスト' do
    it '有効なフォルダデータの場合は保存できること' do
      folder = build(:folder)
      expect(folder).to be_valid
    end

    it 'フォルダ名がない場合は保存できないこと' do
      folder = build(:folder, name: nil)
      expect(folder).not_to be_valid
      expect(folder.errors[:name]).not_to be_empty
    end

    it '同じユーザー内で同じフォルダ名は保存できないこと（一意性の検証）' do
      user = create(:user)
      create(:folder, user: user, name: '学習')

      duplicate_folder = build(:folder, user: user, name: '学習')
      expect(duplicate_folder).not_to be_valid
      expect(duplicate_folder.errors[:name]).not_to be_empty
    end

    it '異なるユーザーであれば、同じフォルダ名でも保存できること（スコープの検証）' do
      user1 = create(:user)
      user2 = create(:user)
      create(:folder, user: user1, name: '学習')
      
      folder_by_other_user = build(:folder, user: user2, name: '学習')
      expect(folder_by_other_user).to be_valid
    end
  end
end