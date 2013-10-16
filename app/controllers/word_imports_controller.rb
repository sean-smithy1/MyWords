class WordImportsController < ApplicationController

before_filter :signed_in_user, only: [:new, :create]
before_filter :correct_user, only: [:new, :create]

  def new
    @word_import = WordImport.new
  end

  def create
    @word_import = WordImport.new(word_import_params)
    if @word_import.save
      redirect_to root_url, notice: "Imported words successfully."
    else
      render :new
    end
  end

  def word_import_params
    params[:word_import].merge("@list_id" => 4)
    params.require(:word_import).permit(:file)
  end

private

  def correct_user
    @list = current_user.lists.find_by_id(params[:list_id])
    redirect_to root_url if @list.nil?
  end
end
