class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { teacher: 0, student: 1, guardian: 2 }

  before_create :set_default_role

  # 講師として複数の生徒を持つ
  has_many :students, dependent: :destroy
  # 生徒として自分自身の生徒情報を持つ
  has_one :student, -> { where(user_id: User.where(role: :student).select(:id)) }, foreign_key: :user_id, dependent: :destroy

  private

  def set_default_role
    self.role ||= :student
  end
end
