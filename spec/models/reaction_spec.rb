require 'rails_helper'

RSpec.describe Reaction, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post) }

  it '同じユーザーは同じ投稿に2回reactionできない' do
    create(:reaction, user: user, post: post)
    duplicate = build(:reaction, user: user, post: post)

    expect(duplicate).not_to be_valid
  end
end
