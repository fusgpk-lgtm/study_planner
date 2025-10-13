class Users::RegistrationsController < Devise::RegistrationsController
  # 新規登録画面の拡張
  def new
    build_resource({})
    resource.role = params[:role] if params[:role].present?
    respond_with resource
  end

  # 登録時に role を設定（未指定なら student）
  def create
    build_resource(sign_up_params)
    resource.role ||= :student
    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  private

  # nameを許可しておく
  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
  end
end