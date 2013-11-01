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
    if unique_words?
      begin
        @list.update(list_params)
      rescue ActiveRecord::RecordNotUnique => e
        logger.error "list_controller::create => exception #{e.class.name} : #{e.message}"
        flash[:error] = "<br/>Detailed error: #{e.message}"
        @word=Word.find_by word: params([:list][:word_attributes][:word])
        Lists_word.create(params[:id], @word_id.id)
      end
        redirect_to @list
    else
        logger.error "Words are not unique"
        flash[:error] = "Words are not unique"
        redirect_to @list
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
    params[:list][:words_attributes].each_value { |value| submitted_words << value[:word] }
    true if submitted_words.length == submitted_words.uniq.length
  end


end
