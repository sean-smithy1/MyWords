class ListsController < ApplicationController

  before_filter :signed_in_user, only: [:show, :create, :destroy, :clear_words]
  before_filter :list_owner,   only: [:destroy, :update, :clear_words]

  def new
    @list = List.new
  end

  def create
    @list=current_user.lists.build(list_params)
      if @list.save
        redirect_to edit_list_path(@list), flash: { success: "Successfully created your list."}
      else
        render :new
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
    if @list.update_attributes(listname: list_params[:listname])
      @list.attributes = list_params
      if words_are_unique?
        if @list.create_or_associate
          redirect_to edit_list_path(@list), flash: { success: "List updated" }
          return
        end
      end
      render :edit
    end
  end

  def clear_words
    @list=current_user.lists.find(params[:id])
    if @list.words.clear
      redirect_to edit_list_path(@list), flash: { success: "All word removed" }
    else
      render :edit
    end
  end

 private

  def list_params
    params.require(:list).permit(:id, :listname, :listtype,
     words_attributes:  [ :id, :word ])
  end

  def list_owner
    @list = current_user.lists.find_by_id(params[:id])
    redirect_to root_url if @list.nil?
  end

  def words_are_unique?
    # Unique words submitted, no double up's in current list
    # Catch before getting to Model.
    word_counts=Hash.new(0)
    nested_words=params[:list][:words_attributes].map { |k,v| v[:word] }
    nested_words.each{ |val| word_counts[val]+=1 }
    word_counts.reject!{ |val,count| count==1 }.keys
    puts "**Debug -- Words: #{word_counts}"

    if word_counts.length==0
      true
    else
      @list.errors[:base] << "You have duplicate words in this list"
      false
    end
  end
end
