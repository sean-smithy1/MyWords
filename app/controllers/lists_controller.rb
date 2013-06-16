class ListsController < ApplicationController
  before_filter :signed_in_user, only: [:show, :create, :destroy]
  before_filter :correct_user,   only: :destroy


  def show
    @list = List.find(params[:id])
  end

  def new
    @list = List.new
  end

 
  def create
    @list = current_user.lists.build(params[:listname])
    if @list.save
      flash[:success] = "List Created - Now add some Words"
    else
      @list = []
      render 'static_pages/home'
    end
  end

 private

    def correct_user
      @list = current_user.lists.find_by_id(params[:id])
      redirect_to root_url if @list.nil?
    end

end
