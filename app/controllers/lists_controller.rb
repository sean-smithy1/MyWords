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
    unique?
fail
    begin
      @list.update(list_params)
    rescue ActiveRecord::RecordNotUnique => e
      logger.error "list_controller::create => exception #{e.class.name} : #{e.message}"
      flash[:error] = "<br/>Detailed error: #{e.message}"
    end
      redirect_to @list
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

  def unique?
    submitted_words= params[:words_attributes]
    submitted_words.values!

    if submitted_words.count = submitted_words.uniq.count
      true
    else
      logger.error "Words are not unique"
      flash[:error] = "Words are not unique"
      false
    end
  end

end
