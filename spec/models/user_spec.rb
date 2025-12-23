require 'rails_helper'

RSpec.describe User, type: :model do
  describe "バリデーション" do
    describe "name" do
      it "存在しない場合は無効である" do
        user = build(:user, name: nil)
        expect(user).to be_invalid
        expect(user.errors.details[:name]).to include(error: :blank)
      end

      it "50文字以内であれば有効である" do
        user = build(:user, name: "a" * 50)
        expect(user).to be_valid
      end

      it "51文字以上の場合は無効である" do
        user = build(:user, name: "a" * 51)
        expect(user).to be_invalid
        expect(user.errors.details[:name])
          .to include(a_hash_including(error: :too_long))
      end

      it "重複した名前は無効である" do
        create(:user, name: "duplicate_name")
        user = build(:user, name: "duplicate_name")
        expect(user).to be_invalid
        expect(user.errors.details[:name]).to include(a_hash_including(error: :taken))
      end
    end

    describe "password" do
      context "create時" do
        it "存在しない場合は無効である" do
          user = build(:user, password: nil)
          expect(user).to be_invalid
          expect(user.errors.details[:password]).to include(error: :blank)
        end
      end

      context "update時" do
        it "空でも有効である" do
          user = create(:user)
          user.password = nil
          expect(user).to be_valid
        end
      end
    end

    describe "uid" do
      it "uidがnilでも有効である（emailログイン）" do
        user = build(:user, provider: "email", uid: nil)
        expect(user).to be_valid
      end

      it "同じprovider内で重複したuidは無効である" do
        create(:user, uid: "uid123", provider: "google")
        user = build(:user, uid: "uid123", provider: "google")

        expect(user).to be_invalid
        expect(user.errors.details[:uid]).to include(a_hash_including(error: :taken))
      end
    end
  end
end
