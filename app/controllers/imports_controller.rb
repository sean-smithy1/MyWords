class ImportsController < ApplicationController
  include ListsHelper

  before_filter :signed_in_user, only: [:new, :create]
  before_filter :list_owner, only: [:new, :create]

  def new
    @list=List.find(params[:list_id]) if params[:list_id].present?
    @import_lists = Import.new
  end

  def create
    @import_lists = Import.new(import_list_params)
    @list=List.find(@import_lists.list_id)
    if @import_lists.save
      redirect_to edit_list_path(@list), flash: { notice: "Imported list successfully."}
    else
      render :new
     end
  end

private

  def list_owner
    if params[:list_id].present?
      unless list_owner?(params[:list_id])
        flash[:error] = "You must own the list you are importing into"
        redirect_to root_url
      end
    end
  end


  def import_list_params
    params.require(:import).permit(:file, :list_id
      )
  end
end
