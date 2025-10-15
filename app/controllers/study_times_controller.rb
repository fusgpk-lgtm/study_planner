class StudyTimesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_student

  def index
    # 最新1週間分の学習時間を取得
    @study_times = @student.study_times
                          .where(study_date: 7.days.ago.to_date..Date.today)
                          .order(:study_date)
  end

  def create
    @study_time = @student.study_times.new(study_time_params)
    if @study_time.save
      redirect_to student_path(@student), notice: "学習時間を記録しました。"
    else
      redirect_to student_path(@student), alert: "学習時間の登録に失敗しました。"
    end
  end

  private

  def set_student
    @student = current_user.student || Student.find(params[:student_id])
  end

  def study_time_params
    params.require(:study_time).permit(:study_date, :minutes)
  end
end
