class ListsController < ApplicationController

  before_filter :signed_in_user, only: [:show, :create, :destroy]
  before_filter :list_owner,   only: [:destroy, :update]

  def new
    @list = List.new
  end

  def show
    @list = List.find(params[:id])
  end

  def create
    @list=current_user.lists.build(list_params)
    if @list.words_are_unique?
      if @list.save
        redirect_to @list, notice: "Successfully created a list."
      else
        redirect_to @list, notice: "There was an error saving your list"
      end
      redirect_to @list, notice: "Your list has duplicate entries"
    end
  end

  def destroy
    logger.error " The List to destroy is: #{@list.to_s}"
    @list.destroy
    redirect_to root_url, notice: "List removed."
  end

  def edit
    @list = current_user.lists.find(params[:id])
  end

  def update
    @list.attributes = list_params
    if @list.create_or_associate
      redirect_to @list, notice: "List Update"
    else
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
