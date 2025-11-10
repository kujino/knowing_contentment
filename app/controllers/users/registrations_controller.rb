class Users::RegistrationsController < Devise::RegistrationsController

  protected

  #サインアップ後のリダイレクト先
  def after_sign_up_path_for(resource)
    root_path
  end
end