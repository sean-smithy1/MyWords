class ImportsController < ApplicationController

before_filter :signed_in_user, only: [:new, :create]
before_filter :list_owner, only: [:import_words]

  def import_words
    @word_import=Import.new
    @word_import.list_id=params[:list_id]
  end

  def new
    @lists_import = Import.new
  end

  def create
    @lists_import = Import.new(list_import_params)
    if @list_import.save
      redirect_to root_url, notice: "Imported words successfully."
    else
      render :new
    end
  end

  def list_import_params
    params.require(:list_import).permit(:file)
  end

  def list_owner
    @list = current_user.lists.find_by_id(params[:list_id])
    redirect_to root_url if @list.nil?
  end
end
