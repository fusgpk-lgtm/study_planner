class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { teacher: 0, student: 1, guardian: 2 }

  before_create :set_default_role

  has_one :student, dependent: :destroy

  private

  def set_default_role
    self.role ||= :student
  end
end
