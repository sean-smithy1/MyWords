class ListsController < ApplicationController
  before_filter :signed_in_user, only: [:show, :create, :destroy]
  before_filter :correct_user,   only: :destroy

  def new
    @list = List.new
  end

  def show
    @list = current_user.lists.find(params[:id])
  end
 
  def create
    @list = current_user.lists.build(params[:list])
    if @list.save
      flash[:success] = "List Created - Now add some Words"
      redirect_to @list
    else
      render 'new'
    end
  end

  def destroy
    @list.destroy
    redirect_to root_url
  end

 private

    def correct_user
      @list = current_user.lists.find_by_id(params[:id])
      redirect_to root_url if @list.nil?
    end
end
