class ImportsController < ApplicationController

before_filter :signed_in_user, only: [:new, :create, :import_words]
before_filter :list_owner, only: [:import_words]

  def import_words
    @word_import=Import.new(list_id: params[:id])
    @list=List.find_by_id(params[:id])
  end

  def new
    @lists_import = Import.new
  end

  def create
    @lists_import = Import.new(list_import_params)
    if @lists_import.save
      redirect_to root_url, notice: "Imported words successfully."
    else
      render :new
    end
  end


private

  def list_import_params
    params.require(:import).permit(:file, :list_id, :user_id)
  end

  def list_owner
    redirect_to root_url notice: "List not owned by you, please contact support if this is an error" if current_user.lists.find_by_id(params[:id]).nil?
  end

  def user_id
    current_user.user_id
  end
end
