class Import
include ActiveModel::Model

  attr_accessor :file, :list_id

  def initialize(attributes = {})
      attributes.each { |name, value| send("#{name}=", value) }
  end

##Have Removed the persisted method. Not needed I beleive

  def save
    if load_imported_lists(1)
      true
    else
      false
    end
  end

  def load_imported_lists(list_num)
    @spreadsheet = open_spreadsheet
    @list=List.find_by_id(list_id) || List.new

    arry_import_words=words_in_list(list_num)
    arry_original_list_words=@list.word_ids
    arry_new_list_words = arry_import_words | arry_original_list_words

    if arry_new_list_words.count <= List::MAXWORDS
      if @list.word_ids=arry_new_list_words
        true
      else
        # Raise an exception - somthing went wrong with the save
      end
    else
      self.errors[:base] << "The list #{@list.listname} exceeds the maximum of words #{List::MAXWORDS} allowed."
      false
    end
  end

  def number_of_lists
    @spreadsheet.last_column > List::MAXLISTS ? List::MAXLISTS : @spreadsheet.last_column
  end

  def words_in_list(col_num)
    import_ids=[]
    (2..@spreadsheet.last_row).each do |row_num|
      unless @spreadsheet.cell(row_num, col_num) == ""
          word=Word.find_or_create_by(word: @spreadsheet.cell(row_num, col_num))
        unless import_ids.include?(word.id)
          import_ids << word.id
        else
          self.errors[:base] << "The word #{word.word} is included multiple times in your list, it was skipped."
        end
      end
    end
    import_ids
  end

  def open_spreadsheet
    case File.extname(file.original_filename)
      when ".ods" then Roo::OpenOffice.new(file.path, nil, :ignore)
      when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
      when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
      when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
    else
      raise "Unknown file type: #{file.original_filename}"
    end
  end
end

