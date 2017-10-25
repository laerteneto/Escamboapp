require 'spec_helper'
require 'doctor_ipsum'

describe "DoctorIpsum paragraphs(s) and longer: " do

  let(:lorem) { DoctorIpsum::Lorem }

  describe 'Lorem Paragraph' do
    it 'should output String, not Array' do
      lorem.paragraph.class.should eq String
      lorem.paragraph.class.should_not eq Array
    end

    it "should produce correct number of sentences" do
      100.times do
        rn = rand(10)
        lorem.paragraph(rn,true).split('.').count.should eq (rn)
      end
    end
  end

  describe 'Lorem Paragraphs' do
    it 'should output String, not Array' do
      lorem.paragraphs.class.should eq String
      lorem.paragraphs.class.should_not eq Array
    end

    it 'should produce correct number of paragraphs' do
      100.times do
        rn = rand(10)
        lorem.paragraphs(rn,true).split("\n\n").count.should eq(rn)
      end
    end
  end

end


