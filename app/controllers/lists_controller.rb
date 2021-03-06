class ListsController < ApplicationController
  include ListsHelper

  before_filter :signed_in_user, only: [:show, :create, :destroy, :clear_words, :import]
  before_filter :list_owner,   only: [:destroy, :update, :clear_words, :import]

  def new
    @list = List.new
  end

  def create
    @list=current_user.lists.build(list_params)
      if @list.save
        redirect_to edit_list_path(@list), flash: { notice: "Successfully created your list."}
      else
        render :edit
      end
  end

  def destroy
    @list.destroy
    redirect_to root_url, flash: { notice: "The list #{@list.to_s} has been deleted" }
  end

  def edit
    @list = List.find(params[:id])
  end

  def show
    @list=List.find(params[:id])
  end

  # TODO: Refractor
  def update
    @list = List.find(params[:id])
    arry_add_words=Array.new

    # Update Listname if change
    unless @list.listname == params[:list][:listname]
      @list.update_attribute(:listname, params[:list][:listname])
    end

    if words_are_unique?
      this_lists_words = params[:list][:words_attributes]

      if this_lists_words.count > List::MAXWORDS
        @list.errors[:base] << "You have to many words in your list"
        render :edit
        return
      else
        @list.words = [] if @list.persisted?
        this_lists_words.each do |k,w|
          the_word = Word.find_or_create_by(word: w[:word])
          arry_add_words << the_word.id
        end
      end

      if @list.word_ids=arry_add_words
          redirect_to edit_list_path(@list), flash: { notice: "Successfully updated your list."}
      else
          # Somthing went wrong with the save
      end

    else
      @list.errors[:base] << "You have duplicate words in this list"
      render :edit
    end
  end

  def clear_words
    @list=List.find(params[:id])
    if @list.words.clear
      redirect_to edit_list_path(@list), flash: { notice: "All words removed" }
    else
      render :edit
    end
  end

 private

  def list_params
    params.require(:list).permit(:id, :listname, :listtype,
     words_attributes:  [ :id, :word ])
  end

  def words_are_unique?
    # Unique words submitted, no double up's in current list
    # Catch before getting to Model.
    word_counts=Hash.new(0)
    nested_words=params[:list][:words_attributes].map { |k,v| v[:word] }
    nested_words.each{ |val| word_counts[val]+=1 }
    word_counts.reject!{ |val, count| count==1 }

    if word_counts.length==0
      return true
    else
      return false
    end
  end

  def list_owner
    unless list_owner?(params[:id])
      flash[:error] = "You must own the list you are modifing"
      redirect_to root_url
    end
  end

end
