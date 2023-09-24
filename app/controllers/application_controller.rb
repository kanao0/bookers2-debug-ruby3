class ApplicationController < ActionController::Base
  # ログインしてない人がアクセスするとログイン画面に戻る＊top,about画面は除く
  before_action :authenticate_user!, except: [:top,:about ]
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  # ログインした後どこ行く？
  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
