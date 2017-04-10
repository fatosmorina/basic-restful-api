class AuthorizeApiRequest

  def initialize(headers = {})
    @headers = headers
  end

  def call
    {
        user: user
    }
  end

  private

  attr_reader :headers

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
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