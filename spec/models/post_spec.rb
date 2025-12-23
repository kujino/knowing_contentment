require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) do
    User.create!(
      name: 'テストユーザー',
      email: 'test@example.com',
      password: 'password'
    )
  end

  let(:theme) do
      Theme.create!(title: 'テスト', description: 'テスト' )
  end

  def attach_image(post, filename:, content_type:)
    post.image.attach(
      io: File.open(Rails.root.join("spec/fixtures/files/#{filename}")),
      filename: filename,
      content_type: content_type
    )
  end

  context 'content のバリデーション' do
    it 'content があれば有効である' do
      post = Post.new(content: 'テスト投稿', user: user, theme: theme)
      expect(post).to be_valid
    end

    it 'content が空だと無効である' do
      post = Post.new(content: '', user: user, theme: theme)
      expect(post).to be_invalid
    end

    it 'content が300文字以内なら有効である' do
      post = Post.new(content: 'a' * 300, user: user, theme: theme)
      expect(post).to be_valid
    end

    it 'content が300文字を超えると無効である' do
      post = Post.new(content: 'a' * 301, user: user, theme: theme)
      expect(post).to be_invalid
    end
  end

  context 'image のバリデーション（content_type）' do
    it 'jpeg/png/webp は有効である' do
      post = Post.new(content: 'テスト投稿', user: user, theme: theme)
      attach_image(post, filename: 'under_5mb.jpg', content_type: 'image/jpeg')

      expect(post).to be_valid
    end

    it '許可されていない content_type は無効である' do
      post = Post.new(content: 'テスト投稿', user: user, theme: theme)
      attach_image(post, filename: 'sample.txt', content_type: 'text/plain')

      expect(post).to be_invalid
    end
  end

  context 'image のバリデーション（size）' do
    it '5MB 以下なら有効である' do
      post = Post.new(content: 'テスト投稿', user: user, theme: theme)
      attach_image(post, filename: 'under_5mb.jpg', content_type: 'image/jpeg')

      expect(post).to be_valid
    end

    it '5MB を超えると無効である' do
      post = Post.new(content: 'テスト投稿', user: user, theme: theme)
      attach_image(post, filename: 'over_5mb.jpg', content_type: 'image/jpeg')

      expect(post).to be_invalid
    end
  end
end
