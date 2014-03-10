class ImportsController < ApplicationController

before_filter :signed_in_user, only: [:new, :create, :import_words]
before_filter :list_owner, only: [:new_import_words]

# -- Import into existing List

  def import_words
    @list=List.find(params[:id])
    @import_words=Import.new
  end

# -- Create New Lists

  def new
    @import_lists = Import.new
  end

  def create
    @import_lists = Import.new(import_list_params)
    if @import_lists.save
      @list=List.find(@import_lists.list_id)
      redirect_to edit_list_path(@list), flash: { notice: "Imported list successfully."}
    else
      render :import_words
     end
  end

private

  def import_list_params
    params.require(:import).permit(:file, :list_id
      )
  end

  def list_owner
    redirect_to root_url notice: "List not owned by you, please contact support if this is an error" if current_user.lists.find_by_id(params[:id]).nil?
  end

  def user_id
    current_user.user_id
  end
end
