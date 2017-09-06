class JsonWebToken
  # secret token used for encoding and decoding purposes

  HMAC_SECRET = Rails.application.secrets.secret_key_base

  def self.encode(payload, exp = 24.hours.from_now)
    # set expiry to 24 hours from creation time
    payload[:exp] = exp.to_i
    # sign token with application's secret key
    JWT.encode(payload, HMAC_SECRET)
  end

  def self.decode(token)
    # get payload - first index in decoded Array
    body = JWT.decode(token, HMAC_SECRET)[0]
    HashWithIndifferentAccess.new body

    # rescue from expiry exception
  rescue JWT::ExpiredSignature, JWT::VerificationError => exception
    # raise custom error that should be handled by custom handler
    raise ExceptionHandler::ExpiredSignature, exception.message
  end

end
