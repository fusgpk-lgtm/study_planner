class ApplicationController < ActionController::Base
  before_action :basic_auth

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      # 環境変数が設定されている場合のみ認証を行う
      ENV['BASIC_AUTH_USER'].present? && ENV['BASIC_AUTH_PASSWORD'].present? &&
        username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end
end
