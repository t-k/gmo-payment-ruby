require "spec_helper"

describe "GMO::Payment::API" do

  describe "#get_request" do
    it "raises" do
      lambda {
        service = GMO::Payment::API.new()
        service.get_request("foo")
      }.should raise_error(RuntimeError)
    end
  end

  describe "#post_request" do
    it "raises" do
      lambda {
        service = GMO::Payment::API.new()
        service.post_request("foo")
      }.should raise_error(RuntimeError)
    end
  end

  describe "#api_call" do
    it "raises" do
      lambda {
        service = GMO::Payment::API.new()
        service.api_call
      }.should raise_error(NoMethodError)
    end
  end

end
