class ListsController < ApplicationController
  before_filter :signed_in_user, 
                only: [:index, :edit, :update, :destroy]
  before_filter :correct_user,   only: [:edit, :update]

  def show
    @list = List.find(params[:id])
  end

  def new
    @list = List.new
  end
  
  def create
    @list = List.new(params[:listname], :user_id=>1, :listtype=>'u' )
    if @list.save
      flash[:success] = "List Created - Now add some Words"
    else
      render 'new'
    end
  end
end
