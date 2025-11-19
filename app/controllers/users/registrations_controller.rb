class Users::RegistrationsController < Devise::RegistrationsController
  protected

  # サインアップ後のリダイレクト先
  def after_sign_up_path_for(resource)
    mypage_path
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def after_update_path_for(resource)
    mypage_path(resource)
  end
end
