require 'spec_helper'
require 'doctor_ipsum'

describe DoctorIpsum do

  it "must have correct name" do
    DoctorIpsum.name.should eq('DoctorIpsum')
  end
  it "must be defined (VERSION)" do
    DoctorIpsum::VERSION.should_not eq(nil)
  end

end


