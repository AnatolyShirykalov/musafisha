class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    omniauth_registration :facebook
  end

  def vkontakte
    omniauth_registration :vkontakte
  end

  protected
  def omniauth_registration provider
    token = request.env["omniauth.auth"]

    @user = User.from_omniauth(token)
    # @provider = UserProvider.find_by_token(token)

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: provider.to_s) if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end
