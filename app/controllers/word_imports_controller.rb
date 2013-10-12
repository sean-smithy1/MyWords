class WordImportsController < ApplicationController

  def new
    @word_import = WordImport.new
  end

  def create
    @word_import = WordImport.new(word_import_params)
    if @word_import.save
      redirect_to root_url, notice: "Imported words successfully."
    else
      render :new
    end
  end

  def word_import_params
    params.require(:word_import).permit(:file)
  end

end
