class UnitsController < ApplicationController
  before_action :set_textbook
  def new
    @unit = @textbook.new
  end

  def create
    @unit = @textbook.units.new(unit_params)
    if @unit.save
      redirect_to student_path(params[:student_id]), notice: '単元を追加しました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_textbook
    @textbook = Textbook.find(params[:textbook_id])
  end

  def unit_params
    params.require(:unit).permit(:title, :order)
  end
end
