class ListsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy


  def show

  end
 
  def create
    @list = current_user.list.build(params[:listname])
    if @list.save
      flash[:success] = "List Created - Now add some Words"
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

 private

    def correct_user
      @list = current_user.lists.find_by_id(params[:id])
      redirect_to root_url if @list.nil?
    end

end
