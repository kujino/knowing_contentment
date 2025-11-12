class Users::SessionsController < Devise::SessionsController
  
  protected

  def after_sign_in_path_for(sesouce)
    mypage_path
  end

  def after_sign_out_path_for(resouce)
    root_path
  end
end
