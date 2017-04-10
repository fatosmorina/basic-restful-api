class AuthorizeApiRequest
  def initialize(headers = {})

  end

  def call
    {
        user: user
    }
  end
end