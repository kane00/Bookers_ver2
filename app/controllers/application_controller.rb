class ApplicationController < ActionController::Base
	
	before_action :configure_permitted_parameters, if: :devise_controller?
	#デバイス機能実行前にconfigure_permitted_parametersの実行をする。
	

  protected
  # ログイン後表示ページをマイページ(user/show)へ
  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  #logout後のredirect先をrootパス(home/top)へ
  def after_sign_out_path_for(resource)
    root_path(resource)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
    #sign_upの際にnameのデータ操作を許可
  end
end
