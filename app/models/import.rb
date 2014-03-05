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
    if load_imported_lists(&:valid?)
      load_imported_lists(&:save!)
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
    list=List.find_by_id(list_id) || List.new
    list.listname=spreadsheet.cell(1,1)
    if list.words_remaining >= spreadsheet.last_row

      import_attributes.merge!(listname: spreadsheet.cell(1,1), words_attributes: {})

      (2..spreadsheet.last_row).each do |i|
          word=Word.find_or_create_by(word: spreadsheet.cell(i,1))
          import_attributes[:words_attributes].merge!(word.id.to_s => {word: word.word})
      end

      list.attributes.merge!(import_attributes)
      list #return the list to save
    end
    errors.add :base "Row #{index+2}: #{message}"
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

