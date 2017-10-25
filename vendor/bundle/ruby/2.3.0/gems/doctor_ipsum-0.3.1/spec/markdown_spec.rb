require 'spec_helper'
require 'doctor_ipsum'

describe "DoctorIpsum Markdown: " do
  let(:md) { DoctorIpsum::Markdown }

  describe 'Header' do
    it 'should add correct header and length' do
      100.times do
        level = rand(1..6)
        md.header( DoctorIpsum::Lorem.sentence(3), level )[0..level-1].should
          eq('#'*level)
      end
    end
    it 'should have upper bound of 6' do
      100.times do
        md.header( DoctorIpsum::Lorem.sentence(3), rand(1..100) ).count('#').should <= 6
      end
    end
  end

  describe 'Emphasis' do
    it 'should add correct header and length' do
      100.times do
        level = rand(1..2)
        sentence = DoctorIpsum::Lorem.sentence(3)
        md.emphasis( sentence, level )[0..level-1].should eq('_'*level)
        md.emphasis( sentence, level )[-level..-1].should eq('_'*level)
      end
    end

    it 'should have upper limit of 2' do
      100.times do
        md.emphasis( DoctorIpsum::Lorem.sentence(3), rand(1..100) ).count('_').should <= 4
      end
    end
  end

  describe 'Blockquote' do
    it 'should add > before/after each newline' do
      100.times do
        md.blockquote( DoctorIpsum::Lorem.sentence(3), 5 ).split("\n").each do |x|
          x[0..1].should eq('> ')
        end
      end
    end
  end

  describe 'List' do
    it 'should create unordered list' do
      100.times do
        md.list( DoctorIpsum::Lorem.words(10) , 3, false).split("\n").each do |x|
          x[0..1].should eq('* ')
        end
      end
    end
    it 'should create ordered list' do
      100.times do
        md.list( DoctorIpsum::Lorem.words(10) , 3, true).split("\n").each.with_index do |x,i|
          x[0..2].should eq((i+1).to_s+'. ')
        end
      end
    end
  end

  describe 'Code block' do
    pending 'Basic code block, Github flavor fencing, and code source'
  end

  describe 'Horizontal rules' do
    it 'should produce 10 dashes' do
      md.horizontal.should eq('-'*10)
    end
  end

  describe 'Links' do
    simple_link_regex = /\[[^\[\]]+\]\(http[s]?:\/\/[a-zA-Z0-9\/._-]+\s*(")?(?:[^\"]*\"\s*\)|\s*\))/
    it "should produce correct (opinionated) link format" do
      100.times { md.link.should match(simple_link_regex) }
    end
    pending 'Add other link formats and reference links'
  end

  describe 'Images' do
    simple_img_regex = /!\[[^\[\]]+\]\(http[s]?:\/\/[a-zA-Z0-9\/._-]+\s*(")?(?:[^\"]*\"\s*\)|\s*\))/
    it 'should have correct image format' do
      100.times { md.image.should match(simple_img_regex) }
    end

    it 'should produce image with correct placehold.it dims' do
      100.times do
        width,height = rand(200..500),rand(200..500)
        md.image(width, height).should include(width.to_s+"x"+height.to_s)
      end
    end
    pending 'images using local cache'
  end

  describe 'Entry' do
  end

end
