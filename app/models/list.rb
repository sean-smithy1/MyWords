class List < ActiveRecord::Base

  belongs_to :user

  has_many :lists_words, -> {order 'lists_words.created_at'}
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

  def create_or_associate
  # For each word submitted
    self.words.each do |the_list|
      if the_list.word_changed? #(New and Changed)

       if Word.exists?(word: the_list.word)
          # edited or new word already in DB
          assoc_rec=self.lists_words.new
          assoc_rec.word_id=Word.where(word: the_list.word).pluck(:id)[0]
          assoc_rec.save #Use Association validation

        elsif the_list.exists?
          #edited word not in the db

          # Dosn't exist but is an edit of an existing one
          # So do I check for anyone else using it and modify the word
          # or just creat a new word, remove old assoc, and add new one leaving an orphen?

        else


          # New word (Doesn't have an ID)
          self.words<<the_list
        end
      end
    end
  end

  def words_are_unique?
# Check for unique words submitted from the form.
# Capture double ups for later highlighting on form-return
    word_counts= Hash.new(0)
    nested_words=self.words.map{ |w| w.word }
    nested_words.each{ |val| word_counts[val]+=1 }
    word_counts.reject!{ |val,count| count==1 }.keys

# This section to add errors to individual words
# Future Activity
    true if word_counts.length==0
  end

private
  def max_words
    self.errors[:base]<<"100 maximun words per list" if words.length>=100
  end
end

