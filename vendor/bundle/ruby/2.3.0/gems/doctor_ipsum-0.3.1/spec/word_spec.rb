require 'spec_helper'
require 'doctor_ipsum'

describe "DoctorIpsum word(s): " do
  let(:lorem) { DoctorIpsum::Lorem }

  describe 'Lorem Word' do
    it 'should output array' do
      lorem.word.class.should eq Array
    end

    it 'should sample from yaml' do
      100.times { lorem.word.should_not be_empty }
    end

    it 'should only give one word' do
      100.times { lorem.word.count.should eq(1) }
    end

  end

  describe 'Lorem words' do
    it 'should output array' do
      100.times { lorem.words(rand(20)+1).class.should eq Array }
    end

    it 'should allow variable number of words' do
      100.times do
        rn = rand(20)+1
        lorem.words(rn).count.should eq(rn)
      end
    end
  end

  describe 'Lorem words with supplemental' do
    it 'should output array' do
      100.times { lorem.words(10,true).class.should eq Array }
    end

    it 'should allow variable number of words' do
      100.times do
        rn = rand(20)+1
        lorem.words(rn,true).count.should eq(rn)
      end
    end
  end

end
