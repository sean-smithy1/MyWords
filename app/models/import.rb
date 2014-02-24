class Import
include ActiveModel::Model

  attr_accessor :file, :list_id, :user_id

  def initialize(attributes = {})
      attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end

  def save
    if load_imported_lists.map(&:valid?).all?
      load_imported_lists.each(&:save!)
      true
    else
       load_imported_lists.each_with_index do |word, index|
        word.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+2}: #{message}"
        end
      end
      false
    end
  end

  def load_imported_lists
    spreadsheet = open_spreadsheet
    list=List.find_by_id(list_id) || List.new(user_id: user_id)
    list.listname=spreadsheet.cell(1,1)
    (2..spreadsheet.last_row).each do |i|
      import_word=spreadsheet.cell(i,1)
      word_to_add = Word.find_or_create_by_word(import_word)

      unless list.word_ids.include?(word_to_add.id)
        list.words << word_to_add
      end

    end
      list #return the list to save
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

private

end

