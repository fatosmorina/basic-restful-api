class AuthorizeApiRequest
  def initialize(headers = {})

  end

  def call
    {
        user: user
    }
  end

  def user
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token

  rescue ActiveRecord::RecordNotFound => exception
    raise(
        ExceptionHandler::InvalidToken,
        ("#{Message.invalid_token} #{exception.message}")
      )
  end

end