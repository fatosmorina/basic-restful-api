module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |exception|
      json_response({ message: exception.message})
    end

    rescue_from ActiveRecord::RecordInvalid do |exception|
      json_response({ message: exception}, :unprocessable_entity)
    end
  end


end