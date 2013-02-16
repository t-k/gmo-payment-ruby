require 'spec_helper'

class FakeHTTPService
  include GMO::HTTPService
end

describe "GMO::HTTPService" do

  describe "common methods" do
    describe "server" do
      it "should return the dev server if options[:development]" do
        FakeHTTPService.server(:development => true).should == GMO::Payment::DEV_SERVER
      end

      it "should return the pro server if !options[:development]" do
        FakeHTTPService.server(:development => false).should == GMO::Payment::PRO_SERVER
      end

    end

  end

end