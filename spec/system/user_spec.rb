require 'rails_helper'

RSpec.describe 'ユーザー機能', type: :system do
  context 'ユーザー登録' do
    it '入力値が正常なら登録' do
      visit new_user_registration_path
      fill_in 'ユーザー名', with: '新規ユーザー_#{SecureRandom.hex(4)}'
      fill_in 'メールアドレス', with: 'new_#{SecureRandom.hex(4)}@example.com'
      fill_in 'パスワード（6文字以上）', with: 'password'
      fill_in 'パスワード（確認用）', with: 'password'
      click_on '登録する'
      expect(page).to have_current_path(mypage_path)
    end

    it '必須項目に空白があると登録できない' do
      visit new_user_registration_path

      fill_in 'ユーザー名', with: ''
      fill_in 'メールアドレス', with: 'new_#{SecureRandom.hex(4)}@example.com'
      fill_in 'パスワード（6文字以上）', with: 'password'
      fill_in 'パスワード（確認用）', with: 'password'

      click_on '登録する'

      expect(page).not_to have_current_path(mypage_path)
    end

    it 'メールアドレスが重複していると登録できない' do
      existing_user = create(:user)

      visit new_user_registration_path

      fill_in 'ユーザー名', with: '新規ユーザー_#{SecureRandom.hex(4)}'
      fill_in 'メールアドレス', with: existing_user.email
      fill_in 'パスワード（6文字以上）', with: 'password'
      fill_in 'パスワード（確認用）', with: 'password'

      click_on '登録する'

      expect(page).not_to have_current_path(mypage_path)
    end
  end

  context 'ログイン' do
    let(:user) { create(:user) }

    it '入力値が正常ならログインできる' do
      visit new_user_session_path

      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'

      expect(page).to have_current_path(mypage_path)
    end

    it 'メールアドレスが違うとログインできない' do
      visit new_user_session_path

      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'

      expect(page).not_to have_current_path(mypage_path)
    end

    it 'パスワードが違うとログインできない' do
      visit new_user_session_path

      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'

      expect(page).not_to have_current_path(mypage_path)
    end
  end
  context 'ログアウト' do
    let(:user) { create(:user) }

    it 'ログアウトボタンでログアウト処理' do
      visit new_user_session_path

      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'

      expect(page).to have_current_path(mypage_path)

      click_link 'ログアウト'

      expect(page).to have_current_path(root_path)
    end
  end
end
