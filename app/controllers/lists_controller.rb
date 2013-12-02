class ListsController < ApplicationController

  before_filter :signed_in_user, only: [:show, :create, :destroy]
  before_filter :list_owner,   only: [:destroy, :update]

  def new
    @list = List.new
  end

  def create
    @list=current_user.lists.build(list_params)
      if @list.save
        redirect_to edit_list_path(@list), flash: { success: "Successfully created your list."}
      else
        redirect_to new_list_path, flash: { error: "There was an error saving your list" }
      end
  end

  def destroy
    @list.destroy
    redirect_to root_url, flash: { success: "The list #{@list.to_s} has been deleted" }
  end

  def edit
    @list = current_user.lists.find(params[:id])
  end

  def update
    @list.attributes = list_params
    if @list.create_or_associate
      redirect_to edit_list_path(@list), flash: { success: "List updated" }
    else
      flash[:error] = 'There was an issue updating your'
      render :edit
    end
  end

 private

  def list_params
    params.require(:list).permit(:id, :listname, :listtype,
     :words_attributes => [:id, :word])
  end

  def list_owner
    @list = current_user.lists.find_by_id(params[:id])
    redirect_to root_url if @list.nil?
  end

end
