class Users::RegistrationsController < Devise::RegistrationsController
  protected
  # Google認証のための記述
  def build_resource(hash = {})
    hash[:uid] = User.create_unique_string
    super
  end

  def update_resource(resource, params)
    return super if params['password'].present?
  
    resource.update_without_password(params.except('current_password'))
  end

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
