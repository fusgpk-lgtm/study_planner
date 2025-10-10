class StudentsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_access, only: [:show]
  def index
    @students = Student.all
  end

  def new
    @student = Student.new
  end

  def create
    Student.create(student_params)
    redirect_to '/'
  end

  def show
    @student = Student.find(params[:id])
    @textbooks = Textbook.includes(units: :progresses)
  end

  private

  def authorize_access
    @student = Student.find(params[:id])
    return unless current_user.student? && current_user.id != @student.user_id

    redirect_to root_path, alert: 'アクセス権限がありません。'
  end

  def student_params
    params.require(:student).permit(:name, :goal_school, :start_date, :goal_date)
  end
end
