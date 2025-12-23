require 'rails_helper'

RSpec.describe 'ユーザー機能', type: :system do
  context 'ユーザー登録' do
    it '入力値が正常なら登録' do
      visit new_user_registration_path
      fill_in 'ユーザー名', with: 'テストユーザー'
      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード（6文字以上）', with: 'password'
      fill_in 'パスワード（確認用）', with: 'password'
      click_on '登録する'
      expect(page).to have_current_path(mypage_path)
    end

    it '必須項目に空白があると登録できない' do
      visit new_user_registration_path

      fill_in 'ユーザー名', with: ''
      fill_in 'メールアドレス', with: 'test2@example.com'
      fill_in 'パスワード（6文字以上）', with: 'password'
      fill_in 'パスワード（確認用）', with: 'password'

      click_on '登録する'

      expect(page).not_to have_current_path(mypage_path)
    end

    it 'メールアドレスが重複していると登録できない' do
      User.create!(
        name: '既存ユーザー',
        email: 'duplicate@example.com',
        password: 'password'
      )

      visit new_user_registration_path

      fill_in 'ユーザー名', with: '別ユーザー'
      fill_in 'メールアドレス', with: 'duplicate@example.com'
      fill_in 'パスワード（6文字以上）', with: 'password'
      fill_in 'パスワード（確認用）', with: 'password'

      click_on '登録する'

      expect(page).not_to have_current_path(mypage_path)
    end
  end

  context 'ログイン' do
    before do
      User.create!(
        name: 'テストユーザー',
        email: 'test@example.com',
        password: 'password'
      )
    end

    it '入力値が正常ならログインできる' do
      visit new_user_session_path

      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'

      expect(page).to have_current_path(mypage_path)
    end

    it 'メールアドレスが違うとログインできない' do
      visit new_user_session_path

      fill_in 'メールアドレス', with: 'wrong@example.com'
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'

      expect(page).not_to have_current_path(mypage_path)
    end

    it 'パスワードが違うとログインできない' do
      visit new_user_session_path

      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード', with: 'wrongpassword'
      click_button 'ログイン'

      expect(page).not_to have_current_path(mypage_path)
    end
  end
  context 'ログアウト' do
    before do
      User.create!(
        name: 'テストユーザー',
        email: 'test@example.com',
        password: 'password'
      )
    end

    it 'ログアウトボタンでログアウト処理' do
      visit new_user_session_path

      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'

      expect(page).to have_current_path(mypage_path)
      
      click_link 'ログアウト'

      expect(page).to have_current_path(root_path)
    end
  end
end