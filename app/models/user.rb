class User < ApplicationRecord

  has_many :todos, foreign_key: :created_by
end
