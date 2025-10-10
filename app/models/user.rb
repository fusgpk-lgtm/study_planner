class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { teacher: 0, student: 1, guardian: 2 }

  has_one :student, dependent: :destroy
end
