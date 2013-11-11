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
    @list = current_user.lists.new(list_params)
    if @list.save
      redirect_to @list, notice: "Successfully created a list."
    else
      redirect_to @list, notice: "Error - possble duplicate entry"
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to root_url, notice: "List removed."
  end

  def edit
    @list = List.find(params[:id])
    @words=@list.words
  end

  def update

    unless unique_words?
      flash[:error] = "Your list contains duplicate words."
      render :edit
      return
    end

    @list.attributes=list_params
    logger.error "Changes: #{@list.changed}"

    if @list.save
      flash[:success] = "List Update"
      redirect_to @list
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

  def unique_words?
    submitted_words=Array.new
    params[:list][:words_attributes].each_value { |key| submitted_words << key[:word] }
    true if submitted_words.length == submitted_words.uniq.length
  end
end
