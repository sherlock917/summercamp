class MemberParameterSanitizer < Devise::ParameterSanitizer
  def sign_up
    default_params.permit(
        :password,
        :password_confirmation,
        :email,
        :name,
        :department
    )
  end
end