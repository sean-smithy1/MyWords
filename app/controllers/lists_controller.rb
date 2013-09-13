class ListsController < ApplicationController
  before_filter :signed_in_user, only: [:show, :create, :destroy]
  before_filter :correct_user,   only: [:destroy, :update]

  def new
    @list = List.new
  end

  def show
    @list = List.find(params[:id])
  end

  def create
    @list = current_user.lists.new(params[:list])
    if @list.save
      redirect_to @list, notice: "Successfully created a list."
    else
      render :new
    end
  end

  def edit
    @list = List.find(params[:id])
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to root_url, notice: "List removed."
  end

  def update
    @list = List.find(params[:id])
      if @list.update(user_params)
        redirect_to @list, notice: "Successfully updated list."
    else
      render :edit
    end
  end


 private

  def user_params
    params.require(:list).permit(:user_id, :listname, :listtype, :words_attributes)
  end

  def correct_user
    @list = current_user.lists.find_by_id(params[:id])
    redirect_to root_url if @list.nil?
  end
end
