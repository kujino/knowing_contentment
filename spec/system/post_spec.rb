require 'rails_helper'

RSpec.describe '投稿機能のCRUD', type: :system do
  include LoginMacros

  context '投稿作成' do
    
    let(:user) { create(:user) }

    let!(:theme) do
      Theme.create!(title: 'テスト', description: 'テスト' )
    end

    it "今日の仏教をみつけるボタンで投稿フォーム表示" do
      login(user)
      visit mypage_path
      click_on "今日の仏教をみつける"

      expect(page).to have_current_path(new_post_path)
    end

    it "入力値が正常なら投稿出来る" do
      login(user)
      visit new_post_path
      fill_in "post_content", with: "テスト投稿"
      click_button "送信"
      expect(page).to have_current_path(/posts\/.+/)
    end

    it '空白での投稿は出来ない' do
      login(user)
      visit new_post_path
      fill_in "post_content", with: ""
      click_button "送信"
      expect(page).not_to have_current_path(/posts\/.+/)
    end
  end

  context '投稿の編集' do

    let(:user) { create(:user) }

    let!(:theme) do
      Theme.create!(title: 'テスト', description: 'テスト' )
    end

    let!(:post) do
      Post.create!(user: user, theme: theme, content: '編集前の投稿')
    end

    it '投稿者本人なら編集できる' do
       login(user)
        visit post_path(post)
        expect(page).to have_link(href: edit_post_path(post))
        find("a[href='#{edit_post_path(post)}']").click
        expect(page).to have_current_path(edit_post_path(post))
        fill_in 'post_content', with: '編集後の内容'
        click_button '送信'
        expect(page).to have_current_path(post_path(post))
        expect(page).to have_content('編集後の内容')
    end
  end

  context '投稿の削除' do

    let(:user) { create(:user) }

    let!(:theme) do
      Theme.create!(title: 'テスト', description: 'テスト' )
    end

    let!(:post) do
      Post.create!(user: user, theme: theme, content: '編集前の投稿')
    end

    it '投稿者本人なら投稿を削除できる' do
      login(user)
      expect(Post.exists?(post.id)).to be true
      page.driver.submit :delete, post_path(post), {}
      expect(Post.exists?(post.id)).to be false
      expect(page).to have_current_path(mypage_path)
    end
  end
end