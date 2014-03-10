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
    if load_imported_lists
      true
    else
      false
    end
  end

  def load_imported_lists
    spreadsheet = open_spreadsheet
    list=List.find_by_id(list_id) || List.new

    list.listname=spreadsheet.cell(1,1)
    if list.words_remaining >= spreadsheet.last_row
      arry_list_words=list.word_ids
      (2..spreadsheet.last_row).each do |i|
          word=Word.find_or_create_by(word: spreadsheet.cell(i,1))
          if arry_list_words.include?(word.id)
            self.errors[:base] << "The word <b>#{word.word}</b> is already in your list and has not been added"
          else
            arry_list_words << word.id
          end
      end
#      Rails.logger.debug "*** The id's are: \n#{arry_list_words.each{ |p| p}}"
#      Rails.logger.debug "*** The list name is: #{list.listname}, with id #{list.id}"
      if list.word_ids=arry_list_words
        return true
      else
        self.errors[:base]<< "Somthing went wrong"
        return false
      end
    end
    self.errors[:base] << "A maximum of #{List::MAXWORDS} is allowed per list."
    return false
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

