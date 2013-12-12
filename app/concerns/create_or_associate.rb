module WordWriter

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

end
