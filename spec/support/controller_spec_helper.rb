module ControllerSpecHelper

  def token_generator(user_id)
    JsonWebToken.encode(user_id: user_id)
  end

end