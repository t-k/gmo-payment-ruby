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

  describe "#associate_options_to_gmo_params" do
    let(:service) { GMO::Payment::API.new() }

    context "with ExecTran.idPass" do
      it "converts access_id and access_pass normally" do
        options = {
          access_id: "test_access_id",
          access_pass: "test_access_pass",
          ret_url: "https://example.com/callback"
        }
        result = service.send(:associate_options_to_gmo_params, "ExecTran.idPass", options)
        expect(result).to eq({
          "AccessID" => "test_access_id",
          "AccessPass" => "test_access_pass",
          "RetUrl" => "https://example.com/callback"
        })
      end
    end

    context "with other API methods" do
      it "converts ret_url to RetURL for standard cases" do
        options = { ret_url: "https://example.com/callback" }
        result = service.send(:associate_options_to_gmo_params, "AnotherAPI", options)
        expect(result).to eq({ "RetURL" => "https://example.com/callback" })
      end
    end
  end

end
