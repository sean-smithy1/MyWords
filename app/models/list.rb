class List < ActiveRecord::Base

  belongs_to :user

  has_many :lists_words
  has_many :words, through: :lists_words, dependent: :delete_all, inverse_of: :lists, order: 'word ASC'

  accepts_nested_attributes_for :words, allow_destroy: :true

  #Validations
  validates :listname, presence: true, length: { maximum: 45, message: "List names should be less than 45 characters" }
  validates :listname, uniqueness: { scope: :user_id, message: "This list name already exists as part of your list collection" }

  #Custom Validations
   validate :max_words

  #Model Associations
  validates_associated :words

  def to_s
    self.listname
  end

  def create_or_associate
  # For each word submitted
    self.words.each do |the_list|
      if the_list.word_changed? #(New and Changed)

        if the_list.id.nil? #new list word
          if Word.exists?(word: the_list.word)
            self.words << Word.where(word: the_list.word)
          else
            #new list word not in DB
            self.words << the_list
          end
        else
          # a changed list word
          if Word.exists?(word: the_list.word)
            # changed word already in DB
            self.words << Word.where(word: the_list.word)
            self.words.find(the_list.id).delete
          else
            #changed word not in DB
            new_word=Word.create(word: the_list.word)
            self.words << new_word
            self.words.find(the_list.id).delete
          end
        end
      end
    end
  end

private
  def max_words
    self.errors[:base]<<"100 maximun words per list" if words.length>=100
  end
end

