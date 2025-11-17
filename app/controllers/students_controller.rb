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
    # ログイン中のユーザー（講師）に紐づく生徒として作成
    @student = current_user.students.new(student_params)

    template = CurriculumTemplate.find_by(goal_school: @student.goal_school)
    @student.curriculum_template = template if template.present?

    if @student.save
      redirect_to @student, notice: '生徒を登録しました。'
    else
      Rails.logger.info @student.errors.full_messages.inspect
      render :new, status: :unprocessable_content
    end
  end

  def show
    @student = Student.find(params[:id])
    @textbooks = Textbook.includes(units: :progresses)
    @study_times = @student.study_times.where(study_date: 7.days.ago.to_date..Date.today)
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
