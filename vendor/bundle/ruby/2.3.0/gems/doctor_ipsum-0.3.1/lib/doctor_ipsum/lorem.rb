module DoctorIpsum
  class Lorem < Base
    class << self

      def word
        fetch('lorem.words').sample 1
      end
      def words(num = 3, supplemental = false)
        (
          fetch('lorem.words') +
          (supplemental ? fetch('lorem.supplemental') : [])
        ).shuffle[0, resolve(num)]
      end

      def sentence(word_count = 5, supplemental = false, extra_words = 3)
        num_words = resolve(word_count) + rand(resolve(extra_words))
        words(num_words, supplemental).join(' ').capitalize + '.'
      end
      def sentences(sentence_count = 5, supplemental = false)
        [].tap { |s|
          resolve(sentence_count).times { s << sentence(5, supplemental) }
        }.join(' ')
      end

      def paragraph(sentence_count = 5, supplemental = false)
        sentences(resolve(sentence_count), supplemental)
      end
      def paragraphs(paragraph_count = 3, supplemental = false)
        [].tap { |p|
          resolve(paragraph_count).times { p << paragraph(5, supplemental) }
        }.join("\n\n")
      end

    end #END SELF

    private

    def self.resolve(value)
      case value
        when Array then value[rand(value.size)]
        when Range then rand((value.last+1) - value.first) + value.first
        else value
      end
    end

  end #END LOREM
end
