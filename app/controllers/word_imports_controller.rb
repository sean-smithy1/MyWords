class WordImportsController < ApplicationController

before_filter :signed_in_user, only: [:new, :create]
before_filter :list_owner, only: [:new, :create]

  def new
    @word_import = WordImport.new
    @word_import.list_id=params[:list_id]
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
    params.require(:word_import).permit(:file)
  end

  def list_owner
    @list = current_user.lists.find_by_id(params[:list_id])
    redirect_to root_url if @list.nil?
  end
end
