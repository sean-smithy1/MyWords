class Import
include ActiveModel::Model
  extend ActiveModel::Callbacks
  define_model_callbacks :initialize

  after_initialize :get_list_name, :if => Proc.new { !list_id.nil? }

  attr_accessor :file, :list_id, :list_name

  def initialize(attributes = {})
    run_callbacks :initialize do
      attributes.each { |name, value| send("#{name}=", value) }
    end
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

private

  def max_num_words?(sp)
    numwords=sp.last_row-1
    true if numwords >= MAXWORDS
  end

  def get_list_name
    list_name=List.find(list_id).listname
  end

end

