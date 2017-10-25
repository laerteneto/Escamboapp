require 'spec_helper'
require 'doctor_ipsum'

describe "DoctorIpsum sentences(s): " do

  let(:lorem) { DoctorIpsum::Lorem }

  describe 'Lorem Sentence' do
    it 'should output String, not Array' do
      lorem.sentence.class.should eq String
      lorem.sentence.class.should_not eq Array
    end

    it 'should start with uppercase' do
      100.times do
        sentence = lorem.sentence
        sentence[0].should eq(sentence[0].upcase)
      end
    end

    it 'should end with period' do
      100.times { lorem.sentence[-1].should eq('.') }
    end

    it 'should produce correct number of words' do
      100.times do
        word_count = rand(10)
        lorem.sentence(word_count, true, 5).split(' ').count.should
          be_between(word_count, word_count+5)
      end
    end
  end

  describe 'Lorem Sentences' do
    it 'should produce correct number of sentences' do
      100.times do
        sentence_count = rand(10)
        lorem.sentences(sentence_count, true).split('.').count.should
          eq(sentence_count)
      end
    end
  end

end

