class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if resource.teacher?
      students_path
    elsif resource.student?
      # user_id が紐づいている Student を探す
      student = Student.find_by(user_id: resource.id)
      student ? student_path(student) : root_path
    else
      root_path
    end
  end

  protected

  def configure_permitted_parameters
    # 新規登録時に:nameパラメータを許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    # アカウント更新時に:nameパラメータを許可
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      # 環境変数が設定されている場合のみ認証を行う
      ENV['BASIC_AUTH_USER'].present? && ENV['BASIC_AUTH_PASSWORD'].present? &&
        username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end
end
