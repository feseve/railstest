class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def forbid_login_user #ログイン中のユーザが不必要なURLへの制限
    if current_user
      flash[:notice] = "すでにログインしています"
      redirect_to closets_path
    end
  end

  def after_sign_up_path_for(resouce)
    user_path(current_user)
  end

  def after_sign_in_path_for(resource)
    user_path(current_user) # ログイン後に遷移するpathを設定
  end

  def after_sign_out_path_for(resource)
    root_path # ログアウト後に遷移するpathを設定
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email])
  end

end
