class List < ActiveRecord::Base

  belongs_to :user

  has_many :lists_words
  has_many :words, through: :lists_words, dependent: :delete_all

  accepts_nested_attributes_for :words, allow_destroy: :true

  #Validations
  validates :listname, presence: true, length: { maximum: 45, message: "List names should be less than 45 characters" }
  validates :listname, uniqueness: { scope: :user_id, message: "This list name already exists as part of your list collection" }

  #Custom Validations
   validate :max_words

  #Model Associations

  def to_s
    self.listname
  end

  def write_words
  # For each word submitted
    if unique_words?
      self.words.each do |the_list|
        if the_list.word_changed?
          #logger.error "The Word: #{the_list.word} Changed State is #{the_list.word_changed?}"
          # Original list word was edited
          if Word.exists?(word: the_list.word)
            # edited word already in DB
            assoc_rec=self.lists_words.new
            assoc_rec.word_id=Word.where(word: the_list.word).pluck(:id)[0]
            logger.error "And it was in the DB"
            true if assoc_rec.save
          else
            # Edited word not in DB
            logger.error "And it wasn't in the DB"
            true if self.words<<the_list
          end
        end
      end
    end
    self.errors[:base]<<"Your list contains duplicate words."
  end

  def unique_words?
# Check for unique words submitted from the form.
# Capture double ups for later highlighting on form-return
    word_counts= Hash.new(0)
    nested_words=words.map{ |w|  w.word }
    nested_words.each{ |val| word_counts[val]+=1 }
    word_counts.reject!{ |val,count| count==1 }.keys

# This section to add errors to individual words
# Future Activity
    logger.error "Duplicate Words: #{word_counts}"
    true if word_counts.length==0
  end

private
  def max_words
    self.errors[:base]<<"100 maximun words per list" if words.length>=100
  end

end

