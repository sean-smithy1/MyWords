class StaticPagesController < ApplicationController
  def home
  end

  def show
    @lists = current_user.lists
  end

  def help
  end

  def about
  end
end
