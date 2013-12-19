class WordImport
include ActiveModel::Model

MAXWORDS=5

  attr_accessor :file, :list_id

  def initialize(attributes = {})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end

  def save
    if @list.save
      return true
    else
      imported_words.each_with_index do |word, index|
        word.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+2}: #{message}"
        end
      end
      return false
    end
  end

  def imported_words
    @imported_words ||= load_imported_words
  end

  def load_imported_words
    @list=List.find(list_id)
    spreadsheet = open_spreadsheet
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
     puts "** row=#{row}"
     word = Word.find_or_create_by(row.to_hash)
     @list.words << word
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

  def max_num_words?(sp)
    numwords=sp.last_row-1
    true if numwords >= MAXWORDS
  end

end

