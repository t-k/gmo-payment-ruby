require 'spec_helper'

class FakeNetHTTPService
  include GMO::NetHTTPService
end

describe "GMO::NetHTTPService" do

  describe "#make_request" do
    let(:mock_http) { double("Net::HTTP") }
    let(:mock_http_session) { double("Net::HTTP session") }
    let(:mock_response) { double("Net::HTTPResponse", code: "200", body: "AccessID=test123") }

    before do
      allow(Net::HTTP).to receive(:new).and_return(mock_http)
      allow(mock_http).to receive(:use_ssl=)
      allow(mock_http).to receive(:start).and_yield(mock_http_session)
    end

    describe "Content-Type header for form-encoded POST requests" do
      it "sets Content-Type to application/x-www-form-urlencoded" do
        expect(mock_http_session).to receive(:post) do |path, body, headers|
          expect(path).to eq("/payment/EntryTran.idPass")
          expect(headers["Content-Type"]).to eq("application/x-www-form-urlencoded")
          mock_response
        end

        FakeNetHTTPService.make_request(
          "/payment/EntryTran.idPass",
          { "ShopID" => "shop123", "OrderID" => "order456" },
          "post",
          { :host => "example.com" }
        )
      end

      it "properly encodes form parameters" do
        expect(mock_http_session).to receive(:post) do |path, body, headers|
          expect(path).to eq("/payment/EntryTran.idPass")
          expect(body).to include("ShopID=")
          expect(body).to include("OrderID=")
          expect(headers["Content-Type"]).to eq("application/x-www-form-urlencoded")
          mock_response
        end

        FakeNetHTTPService.make_request(
          "/payment/EntryTran.idPass",
          { "ShopID" => "shop123", "OrderID" => "order456" },
          "post",
          { :host => "example.com" }
        )
      end
    end

    describe "Content-Type header for JSON POST requests" do
      it "sets Content-Type to application/json for .json paths" do
        expect(mock_http_session).to receive(:post) do |path, body, headers|
          expect(path).to eq("/payment/EntryTran.json")
          expect(headers["Content-Type"]).to eq("application/json")
          mock_response
        end

        FakeNetHTTPService.make_request(
          "/payment/EntryTran.json",
          { "ShopID" => "shop123" },
          "post",
          { :host => "example.com" }
        )
      end
    end

    describe "GET requests" do
      it "appends parameters to query string without Content-Type header" do
        expect(mock_http_session).to receive(:get) do |path_with_query|
          expect(path_with_query).to include("/payment/SearchTrade.idPass?")
          expect(path_with_query).to include("ShopID=")
          mock_response
        end

        FakeNetHTTPService.make_request(
          "/payment/SearchTrade.idPass",
          { "ShopID" => "shop123" },
          "get",
          { :host => "example.com" }
        )
      end
    end
  end
end
