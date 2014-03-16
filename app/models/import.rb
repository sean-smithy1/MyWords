class Import
include ActiveModel::Model

  attr_accessor :file, :list_id

  def initialize(attributes = {})
      attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end

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
    @list.update_attribute(:listname, @spreadsheet.cell(1, list_num))

    arry_import_words=words_in_list(list_num)
    arry_old_list_words=@list.word_ids

    unless enough_slots?(arry_import_words.count)
      arry_new_list_words = arry_import_words & arry_old_list_words
      return true if @list.word_ids=arry_new_list_words
    end
    self.errors[:base] << "The list #{@list.listname} exceeds the maximum of words #{List::MAXWORDS} allowed."
    return false
  end

  def enough_slots?(numwords)
    true if @list.words_remaining >= numwords
  end

  def number_of_lists
    @spreadsheet.last_coloum > 10 ? 10 : @spreadsheet.last_coloum
  end

  def words_in_list(column)
    (2..@spreadsheet.last_row).each do |import_word|
      unless @spreadsheet.cell(import_word, column) == ""
        word=Word.find_or_create_by(word: @spreadsheet.cell(import_word,1))
        unless words_in_list.include?(word.id)
          import_id[] << word.id
        else
          self.errors[:base] << "The word #{word.word} is included multiple times in your list, it was skipped."
        end
      end
    end
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

