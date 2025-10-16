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
    @student = Student.new(student_params)

    # 志望校に対応するテンプレートを自動設定
    template = CurriculumTemplate.find_by(goal_school: @student.goal_school)
    @student.curriculum_template = template if template.present?

    if @student.save
      redirect_to @student, notice: "生徒を登録しました。"
    else
      render :new
    end
  end

  def show
    @student = Student.find(params[:id])
    @textbooks = Textbook.all 
    @template_items = @student.curriculum_template&.template_items&.includes(:textbook)
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
