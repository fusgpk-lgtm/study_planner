require 'ostruct'

class StudentsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_access, only: [:show]
  layout :select_layout

  def index
    @students = Student.all
  end

  def new
    @student = Student.new
  end

  def create
    Student.create(student_params)
    redirect_to students_path
  end

  def show
    @student = Student.find(params[:id])
    @textbooks = Textbook.includes(units: :progresses)

    # 仮の教材データ
    @textbooks = [
      OpenStruct.new(
        title: '数学ⅠA',
        units: [
          OpenStruct.new(title: '数と式', progress: 100, start_date: '2025-09-01', end_date: '2025-09-10'),
          OpenStruct.new(title: '集合と命題', progress: 60, start_date: '2025-09-11', end_date: '2025-09-20'),
          OpenStruct.new(title: '二次関数', progress: 20, start_date: '2025-09-21', end_date: '2025-10-05')
        ]
      ),
      OpenStruct.new(
        title: '英語文法',
        units: [
          OpenStruct.new(title: '時制', progress: 90, start_date: '2025-09-05', end_date: '2025-09-15'),
          OpenStruct.new(title: '助動詞', progress: 50, start_date: '2025-09-16', end_date: '2025-09-30')
        ]
      )
    ]
  end

  private

  def authorize_access
    @student = Student.find(params[:id])
    return unless current_user.student? && current_user.student != @student

    redirect_to root_path, alert: 'アクセス権限がありません。'
  end

  def student_params
    params.require(:student).permit(:name, :goal_school, :start_date, :goal_date)
  end

  def select_layout
    if current_user.teacher?
      'teacher'
    elsif current_user.student?
      'student'
    else
      'application'
    end
  end
end
