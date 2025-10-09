class StudentsController < ApplicationController
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

  def student_params
    params.require(:student).permit(:name, :goal_school, :start_date, :goal_date)
  end
end
