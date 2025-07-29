# Encoding: UTF-8

require "spec_helper"

describe "GMO::Payment::ShopAPI" do

  before(:all) do
    @order_id = generate_id
  end

  before(:each) do
    @shop_site ||= GMO::Payment::ShopAndSiteAPI.new({
      :site_id   => SPEC_CONF["site_id"],
      :site_pass => SPEC_CONF["site_pass"],
      :shop_id   => SPEC_CONF["shop_id"],
      :shop_pass => SPEC_CONF["shop_pass"],
      :host      => SPEC_CONF["host"],
      :locale    => :ja
    })
    @service ||= GMO::Payment::ShopAPI.new({
      :shop_id   => SPEC_CONF["shop_id"],
      :shop_pass => SPEC_CONF["shop_pass"],
      :host      => SPEC_CONF["host"],
      :locale    => :ja
    })
  end

  it "should raise an ArgumentError if no options passed" do
    lambda {
      service = GMO::Payment::ShopAPI.new()
    }.should raise_error(ArgumentError)
  end

  it "has an attr_reader for shop_id" do
    @service.shop_id.should == SPEC_CONF["shop_id"]
  end

  it "has an attr_reader for shop_pass" do
    @service.shop_pass.should == SPEC_CONF["shop_pass"]
  end

  it "has an attr_reader for host" do
    @service.host.should == SPEC_CONF["host"]
  end

  describe "#entry_tran" do
    it "gets data about a transaction", :vcr do
      order_id = @order_id
      result = @service.entry_tran({
        :order_id => order_id,
        :job_cd => "AUTH",
        :amount => 100
      })
      result["AccessID"].nil?.should_not be_truthy
      result["AccessPass"].nil?.should_not be_truthy
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.entry_tran()
      }.should raise_error("Required order_id, job_cd were not provided.")
    end
  end

  describe "#entry_tran_cvs" do
    it "gets data about a transaction", :vcr do
      order_id = @order_id
      result = @service.entry_tran_cvs({
        :order_id => order_id,
        :amount => 100
      })
      result["AccessID"].nil?.should_not be_truthy
      result["AccessPass"].nil?.should_not be_truthy
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.entry_tran_cvs()
      }.should raise_error("Required order_id, amount were not provided.")
    end
  end

  describe "#entry_tran_pay_easy" do
    it "gets data about a transaction", :vcr do
      order_id = @order_id
      result = @service.entry_tran_pay_easy({
        :order_id => order_id,
        :amount => 100
      })
      result["AccessID"].nil?.should_not be_truthy
      result["AccessPass"].nil?.should_not be_truthy
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.entry_tran_pay_easy()
      }.should raise_error("Required order_id, amount were not provided.")
    end
  end

  describe "#entry_tran_paypal" do
    it "gets data about a transaction", :vcr do
      order_id = @order_id
      result = @service.entry_tran_paypal({
        :order_id => order_id,
        :job_cd => 'CAPTURE',
        :amount => 100
      })
      result["AccessID"].nil?.should_not be_truthy
      result["AccessPass"].nil?.should_not be_truthy
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.entry_tran_paypal()
      }.should raise_error("Required order_id, job_cd, amount were not provided.")
    end
  end

  describe "#entry_tran_ganb" do
    it "gets data about a transaction", :vcr do
      order_id = @order_id
      result = @service.entry_tran_ganb({
        :order_id => order_id,
        :amount => 100
      })
      result["AccessID"].nil?.should_not be_truthy
      result["AccessPass"].nil?.should_not be_truthy
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.entry_tran_ganb()
      }.should raise_error("Required order_id, amount were not provided.")
    end
  end


  describe "#entry_tran_linepay" do
    it "gets data about a transaction", :vcr do
      order_id = @order_id
      result = @service.entry_tran_linepay({
        :order_id => order_id,
        :job_cd => 'CAPTURE',
        :amount => 100
      })
      result["AccessID"].nil?.should_not be_truthy
      result["AccessPass"].nil?.should_not be_truthy
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.entry_tran_linepay()
      }.should raise_error("Required order_id, job_cd, amount were not provided.")
    end
  end

  describe "#entry_tran_brandtoken" do
    it "gets data about a transaction", :vcr do
      order_id = @order_id
      result = @service.entry_tran_brandtoken({
        :order_id => order_id,
        :job_cd => "AUTH",
        :amount => 100
      })
      result["AccessID"].nil?.should_not be true
      result["AccessPass"].nil?.should_not be true
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.entry_tran_brandtoken()
      }.should raise_error('Required order_id, job_cd, amount were not provided.')
    end
  end

  describe "#entry_tran_rakuten_id" do
    it "gets data about a transaction", :vcr do
      order_id = @order_id
      result = @service.entry_tran_rakuten_id({
        :order_id => order_id,
        :job_cd => "AUTH",
        :amount => 100
      })
      result["AccessID"].nil?.should_not be true
      result["AccessPass"].nil?.should_not be true
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.entry_tran_rakuten_id()
      }.should raise_error('Required order_id, job_cd, amount were not provided.')
    end
  end

  describe "#entry_tran_docomo" do
    it "gets data about a transaction", :vcr do
      order_id = @order_id
      result = @service.entry_tran_docomo({
        :order_id => order_id,
        :job_cd => "AUTH",
        :amount => 100
      })
      result["AccessID"].nil?.should_not be true
      result["AccessPass"].nil?.should_not be true
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.entry_tran_docomo()
      }.should raise_error('Required order_id, job_cd, amount were not provided.')
    end
  end

  describe "#entry_tran_virtualaccount" do
    it "gets data about a transaction", :vcr do
      order_id = @order_id
      result = @service.entry_tran_virtualaccount({
        :order_id => order_id,
        :amount => 100
      })
      result["AccessID"].nil?.should_not be true
      result["AccessPass"].nil?.should_not be true
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.entry_tran_virtualaccount()
      }.should raise_error('Required order_id, amount were not provided.')
    end
  end

  describe "#entry_tran_suica" do
    it "gets data about a transaction", :vcr do
      order_id = @order_id
      result = @service.entry_tran_suica({
        :order_id => order_id,
        :amount => 100
      })
      result["AccessID"].nil?.should_not be true
      result["AccessPass"].nil?.should_not be true
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.entry_tran_suica()
      }.should raise_error('Required order_id, amount were not provided.')
    end
  end

  describe "#entry_tran_edy" do
    it "gets data about a transaction", :vcr do
      order_id = @order_id
      result = @service.entry_tran_edy({
        :order_id => order_id,
        :amount => 100
      })
      result["AccessID"].nil?.should_not be true
      result["AccessPass"].nil?.should_not be true
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.entry_tran_edy()
      }.should raise_error('Required order_id, amount were not provided.')
    end
  end

  describe "#exec_tran" do
    it "gets data about a transaction", :vcr do
      order_id = generate_id
      client_field_1 = "client_field1"
      result = @service.entry_tran({
        :order_id => order_id,
        :job_cd => "AUTH",
        :amount => 100
      })
      access_id = result["AccessID"]
      access_pass = result["AccessPass"]
      result = @service.exec_tran({
        :order_id      => order_id,
        :access_id     => access_id,
        :access_pass   => access_pass,
        :method        => 1,
        :pay_times     => 1,
        :card_no       => "4111111111111111",
        :expire        => "1405",
        :client_field_1 => client_field_1
      })
      result["ACS"].nil?.should_not be_truthy
      result["OrderID"].nil?.should_not be_truthy
      result["Forward"].nil?.should_not be_truthy
      result["Method"].nil?.should_not be_truthy
      result["PayTimes"].nil?.should_not be_truthy
      result["Approve"].nil?.should_not be_truthy
      result["TranID"].nil?.should_not be_truthy
      result["TranDate"].nil?.should_not be_truthy
      result["CheckString"].nil?.should_not be_truthy
      result["ClientField1"].nil?.should_not be_truthy
      (result["ClientField1"] == client_field_1).should be_truthy
      result["ClientField3"].nil?.should_not be_truthy
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.exec_tran()
      }.should raise_error("Required access_id, access_pass, order_id, card_no, expire were not provided.")
    end

    it "doesn't require card info if token is present", :vcr do
      lambda {
        order_id = generate_id
        result = @service.entry_tran({
          :order_id => order_id,
          :job_cd => "AUTH",
          :amount => 100
        })
        access_id = result["AccessID"]
        access_pass = result["AccessPass"]
        result = @service.exec_tran({
          :order_id      => order_id,
          :access_id     => access_id,
          :access_pass   => access_pass,
          :method        => 1,
          :pay_times     => 1,
          :token         => "onetimetokenfromgmo"
        })
      }.should_not raise_error("Required card_no, expire were not provided.")
    end

    it "converts ret_url to RetUrl for ExecTran.idPass" do
      # Test that ret_url is converted to RetUrl by associate_options_to_gmo_params
      actual_params = nil
      allow(@service).to receive(:api_call) do |name, args, method, options|
        actual_params = args
        {}
      end

      @service.exec_tran({
        :order_id      => "test_order",
        :access_id     => "test_access",
        :access_pass   => "test_pass",
        :method        => 1,
        :pay_times     => 1,
        :card_no       => "4111111111111111",
        :expire        => "1405",
        :ret_url       => "https://example.com/3d-secure-callback"
      })

      expect(actual_params).to include("RetUrl" => "https://example.com/3d-secure-callback")
    end

    context "parameter contains Japanese characters" do
      before { require "kconv" unless defined?(Kconv) }

      it "should correctly handle Japanese", :vcr do
        order_id = generate_id
        client_field_1 = "〜−¢£¬−‖①ほげほげhogehoge"
        result = @service.entry_tran({
          :order_id => order_id,
          :job_cd => "AUTH",
          :amount => 100
        })
        access_id = result["AccessID"]
        access_pass = result["AccessPass"]
        result = @service.exec_tran({
          :order_id       => order_id,
          :access_id      => access_id,
          :access_pass    => access_pass,
          :method         => 1,
          :pay_times      => 1,
          :card_no        => "4111111111111111",
          :expire         => "1405",
          :client_field_1 => client_field_1
        })
        result["ACS"].nil?.should_not be_truthy
        result["OrderID"].nil?.should_not be_truthy
        result["Forward"].nil?.should_not be_truthy
        result["Method"].nil?.should_not be_truthy
        result["PayTimes"].nil?.should_not be_truthy
        result["Approve"].nil?.should_not be_truthy
        result["TranID"].nil?.should_not be_truthy
        result["TranDate"].nil?.should_not be_truthy
        result["CheckString"].nil?.should_not be_truthy
        result["ClientField1"].nil?.should_not be_truthy
        (result["ClientField1"] == client_field_1).should be_truthy
        (result["ClientField1"].encoding.to_s == "UTF-8").should be_truthy
        result["ClientField3"].nil?.should_not be_truthy
      end
    end
  end

  describe "#secure_tran" do
    it "gets data about a transaction", :vcr do
      params = File.read("fixtures/vcr_cassettes/GMO_Payment_ShopAPI/secure_tran_request_params.yml")
      params = YAML.load(params)

      result = @service.secure_tran({
        :pa_res => params["pa_res"],
        :md     => params["md"]
      })
      result["OrderID"].nil?.should_not be_truthy
      result["Forward"].nil?.should_not be_truthy
      result["Method"].nil?.should_not be_truthy
      result["PayTimes"].nil?.should_not be_truthy
      result["Approve"].nil?.should_not be_truthy
      result["TranID"].nil?.should_not be_truthy
      result["TranDate"].nil?.should_not be_truthy
      result["CheckString"].nil?.should_not be_truthy
    end
  end

  describe "#exec_tran_cvs" do
    it "gets data about a transaction", :vcr do
      order_id = generate_id
      client_field_1 = "client_field1"
      result = @service.entry_tran_cvs({
        :order_id => order_id,
        :amount => 100
      })
      access_id = result["AccessID"]
      access_pass = result["AccessPass"]
      result = @service.exec_tran_cvs({
        :order_id      => order_id,
        :access_id     => access_id,
        :access_pass   => access_pass,
        :convenience   => '00001',
        :customer_name => 'コンビニ太郎',
        :customer_kana => 'コンビニタロウ',
        :tel_no        => '0300000001',
        :receipts_disp_11 => 'RSpec Helpdesk',
        :receipts_disp_12 => 'RSpec hotline',
        :receipts_disp_13 => '00:00-00:15',
        :client_field_1 => client_field_1
      })
      result["OrderID"].nil?.should_not be_truthy
      result["Convenience"].nil?.should_not be_truthy
      result["ConfNo"].nil?.should_not be_truthy
      result["ReceiptNo"].nil?.should_not be_truthy
      result["PaymentTerm"].nil?.should_not be_truthy
      result["TranDate"].nil?.should_not be_truthy
      result["CheckString"].nil?.should_not be_truthy
      result["ClientField1"].nil?.should_not be_truthy
      (result["ClientField1"] == client_field_1).should be_truthy
      result["ClientField3"].nil?.should_not be_truthy
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.exec_tran_cvs()
      }.should raise_error(ArgumentError, "Required access_id, access_pass, order_id, convenience, customer_name, customer_kana, tel_no, receipts_disp_11, receipts_disp_12, receipts_disp_13 were not provided.")
    end
  end

  describe "#exec_tran_pay_easy" do
    it "gets data about a transaction", :vcr do
      order_id = generate_id
      result = @service.entry_tran_pay_easy({
        :order_id => order_id,
        :amount => 100
      })
      access_id = result["AccessID"]
      access_pass = result["AccessPass"]
      result = @service.exec_tran_pay_easy({
        :order_id      => order_id,
        :access_id     => access_id,
        :access_pass   => access_pass,
        :customer_name => 'ペイ太郎',
        :customer_kana => 'ペイタロウ',
        :tel_no        => '0300000001',
        :receipts_disp_11 => 'RSpec Helpdesk',
        :receipts_disp_12 => '0300000001',
        :receipts_disp_13 => '00:00-00:15'
      })
      result["OrderID"].nil?.should_not be_truthy
      result["CustID"].nil?.should_not be_truthy
      result["BkCode"].nil?.should_not be_truthy
      result["ConfNo"].nil?.should_not be_truthy
      result["EncryptReceiptNo"].nil?.should_not be_truthy
      result["PaymentTerm"].nil?.should_not be_truthy
      result["TranDate"].nil?.should_not be_truthy
      result["CheckString"].nil?.should_not be_truthy
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.exec_tran_pay_easy()
      }.should raise_error("Required access_id, access_pass, order_id, customer_name, customer_kana, tel_no, receipts_disp_11, receipts_disp_12, receipts_disp_13 were not provided.")
    end
  end

  describe "#exec_tran_paypal" do
    it "gets data about a transaction", :vcr do
      order_id = generate_id
      result = @service.entry_tran_paypal({
        :order_id => order_id,
        :job_cd => 'CAPTURE',
        :amount => 100
      })
      access_id = result["AccessID"]
      access_pass = result["AccessPass"]
      result = @service.exec_tran_paypal({
        :order_id      => order_id,
        :access_id     => access_id,
        :access_pass   => access_pass,
        :redirect_url  => 'https://example.com/path/to/redirect',
        :item_name     => '購入する商品名'
      })
      result["OrderID"].nil?.should_not be_truthy
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.exec_tran_paypal()
      }.should raise_error("Required access_id, access_pass, order_id, item_name, redirect_url were not provided.")
    end
  end

  describe "#exec_tran_ganb" do
    it "gets data about a transaction", :vcr do
      order_id = generate_id
      result = @service.entry_tran_ganb({
        :order_id => order_id,
        :amount => 100
      })
      access_id = result["AccessID"]
      access_pass = result["AccessPass"]
      result = @service.exec_tran_ganb({
        :order_id      => order_id,
        :access_id     => access_id,
        :access_pass   => access_pass,
        :client_field_1 => '加盟店自由項目1です。',
        :client_field_2 => '加盟店自由項目2です。',
        :client_field_3 => '加盟店自由項目3です。',
        :account_holder_optional_name => 'コウザタロウ',
        :trade_days        => '3',
        :trade_reason => '取引事由です。',
        :trade_client_name => '依頼花子',
        :trade_client_mailaddress => 'irai@example.com'
      })
      result["BankCode"].nil?.should_not be_truthy
      result["BankName"].nil?.should_not be_truthy
      result["BranchCode"].nil?.should_not be_truthy
      result["BranchName"].nil?.should_not be_truthy
      result["AccountType"].nil?.should_not be_truthy
      result["AccountNumber"].nil?.should_not be_truthy
      result["AccountHolderName"].nil?.should_not be_truthy
      result["AvailableDate"].nil?.should_not be_truthy
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.exec_tran_ganb()
      }.should raise_error("Required access_id, access_pass, order_id were not provided.")
    end
  end

  describe "#exec_tran_linepay" do
    it "gets data about a transaction", :vcr do
      order_id = generate_id
      result = @service.entry_tran_linepay({
        :order_id => order_id,
        :job_cd => 'CAPTURE',
        :amount => 100
      })
      access_id = result["AccessID"]
      access_pass = result["AccessPass"]
      result = @service.exec_tran_linepay({
        :order_id      => order_id,
        :access_id     => access_id,
        :access_pass   => access_pass,
        :ret_url       => 'https://example.com/path/to/return/success',
        :error_rcv_url => 'https://example.com/path/to/return/failure',
        :product_name  => '購入する商品名'
      })
      result["Start"].nil?.should_not be_truthy
      result["AccessID"].nil?.should_not be_truthy
      result["Token"].nil?.should_not be_truthy
      result["StartURL"].nil?.should_not be_truthy
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.exec_tran_linepay()
      }.should raise_error("Required access_id, access_pass, order_id, ret_url, error_rcv_url, product_name were not provided.")
    end
  end

  describe "#exec_tran_rakuten_id" do
    it "gets data about a transaction", :vcr do
      order_id = generate_id
      result = @service.entry_tran_rakuten_id({
        :order_id => order_id,
        :job_cd => 'CAPTURE',
        :amount => 100
      })
      access_id = result["AccessID"]
      access_pass = result["AccessPass"]
      result = @service.exec_tran_rakuten_id({
        :order_id      => order_id,
        :access_id     => access_id,
        :access_pass   => access_pass,
        :ret_url       => 'https://example.com/path/to/return/success',
        :error_rcv_url => 'https://example.com/path/to/return/failure',
        :item_id       => '0001',
        :item_name     => '購入する商品名'
      })
      result["AccessID"].nil?.should_not be_truthy
      result["Token"].nil?.should_not be_truthy
      result["StartURL"].nil?.should_not be_truthy
      result["StartLimitDate"].nil?.should_not be_truthy
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.exec_tran_rakuten_id()
      }.should raise_error("Required access_id, access_pass, order_id were not provided.")
    end
  end

  describe "#exec_tran_docomo" do
    it "gets data about a transaction", :vcr do
      order_id = generate_id
      result = @service.entry_tran_docomo({
        :order_id => order_id,
        :job_cd => 'CAPTURE',
        :amount => 100
      })
      access_id = result["AccessID"]
      access_pass = result["AccessPass"]
      result = @service.exec_tran_docomo({
        :order_id      => order_id,
        :access_id     => access_id,
        :access_pass   => access_pass,
        :ret_url       => 'https://example.com/path/to/return/success',
        :error_rcv_url => 'https://example.com/path/to/return/failure',
        :item_id       => '0001',
        :item_name     => '購入する商品名'
      })
      result["AccessID"].nil?.should_not be_truthy
      result["Token"].nil?.should_not be_truthy
      result["StartURL"].nil?.should_not be_truthy
      result["StartLimitDate"].nil?.should_not be_truthy
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.exec_tran_docomo()
      }.should raise_error("Required access_id, access_pass, order_id were not provided.")
    end
  end

  describe "#exec_tran_virtualaccount" do
    it "gets data about a transaction", :vcr do
      order_id = generate_id
      result = @service.entry_tran_virtualaccount({
        :order_id => order_id,
        :amount => 100
      })
      access_id = result["AccessID"]
      access_pass = result["AccessPass"]
      result = @service.exec_tran_virtualaccount({
        :order_id      => order_id,
        :access_id     => access_id,
        :access_pass   => access_pass,
        :trade_days    => 14
      })
      result["AccessID"].nil?.should_not be_truthy
      result["BankCode"].nil?.should_not be_truthy
      result["BankName"].nil?.should_not be_truthy
      result["BranchCode"].nil?.should_not be_truthy
      result["BranchName"].nil?.should_not be_truthy
      result["AccountType"].nil?.should_not be_truthy
      result["AccountNumber"].nil?.should_not be_truthy
      result["AvailableDate"].nil?.should_not be_truthy
      result["TradeCode"].nil?.should_not be_truthy
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.exec_tran_virtualaccount()
      }.should raise_error("Required access_id, access_pass, order_id, trade_days were not provided.")
    end
  end

  describe "#exec_tran_suica" do
    it "gets data about a transaction", :vcr do
      order_id = generate_id
      client_field_1 = "client_field1"
      result = @service.entry_tran_suica({
        :order_id => order_id,
        :amount => 100
      })
      access_id = result["AccessID"]
      access_pass = result["AccessPass"]
      result = @service.exec_tran_suica({
        :order_id         => order_id,
        :access_id        => access_id,
        :access_pass      => access_pass,
        :item_name        => '購入する商品名',
        :mail_address     => 'test@example.com',
        :client_field_1   => client_field_1,
        :client_field_flg => 1
      })
      result["OrderID"].nil?.should_not be_truthy
      result["SuicaOrderNo"].nil?.should_not be_truthy
      result["ReceiptNo"].nil?.should_not be_truthy
      result["PaymentTerm"].nil?.should_not be_truthy
      result["TranDate"].nil?.should_not be_truthy
      result["CheckString"].nil?.should_not be_truthy
      (result["ClientField1"] == client_field_1).should be_truthy
      result["ClientField3"].nil?.should_not be_truthy
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.exec_tran_suica()
      }.should raise_error("Required access_id, access_pass, order_id, item_name, mail_address were not provided.")
    end
  end

  describe "#exec_tran_edy" do
    it "gets data about a transaction", :vcr do
      order_id = generate_id
      client_field_1 = "client_field1"
      result = @service.entry_tran_edy({
        :order_id => order_id,
        :amount => 100
      })
      access_id = result["AccessID"]
      access_pass = result["AccessPass"]
      result = @service.exec_tran_edy({
        :order_id         => order_id,
        :access_id        => access_id,
        :access_pass      => access_pass,
        :mail_address     => 'test@example.com',
        :client_field_1   => client_field_1,
        :client_field_flg => 1
      })
      result["OrderID"].nil?.should_not be_truthy
      result["ReceiptNo"].nil?.should_not be_truthy
      result["EdyOrderNo"].nil?.should_not be_truthy
      result["PaymentTerm"].nil?.should_not be_truthy
      result["TranDate"].nil?.should_not be_truthy
      result["CheckString"].nil?.should_not be_truthy
      (result["ClientField1"] == client_field_1).should be_truthy
      result["ClientField3"].nil?.should_not be_truthy
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.exec_tran_edy()
      }.should raise_error("Required access_id, access_pass, order_id, mail_address were not provided.")
    end
  end

  describe "#exec_tran_brandtoken" do
    it "gets data about a transaction", :vcr do
      order_id = generate_id
      client_field_1 = "client_field1"
      result = @service.entry_tran_brandtoken({
        :order_id => order_id,
        :job_cd => "AUTH",
        :amount => 100
      })
      access_id = result["AccessID"]
      access_pass = result["AccessPass"]
      result = @service.exec_tran_brandtoken({
        :order_id    => order_id,
        :access_id   => access_id,
        :access_pass => access_pass,
        :token_type  => :apple_pay,
        :token       => 'base64encodedtoken',
        :client_field_1 => client_field_1
      })
      result["Status"].nil?.should_not be true
      result["OrderID"].nil?.should_not be true
      result["Forward"].nil?.should_not be true
      result["Approve"].nil?.should_not be true
      result["TranID"].nil?.should_not be true
      result["TranDate"].nil?.should_not be true
      result["ClientField1"].should eq client_field_1
      result["ClientField2"].nil?.should_not be true
      result["ClientField3"].nil?.should_not be true
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.exec_tran_brandtoken()
      }.should raise_error("Required access_id, access_pass, order_id were not provided.")
    end

    context "parameter contains Japanese characters" do
      before { require "kconv" unless defined?(Kconv) }

      it "should correctly handle Japanese", :vcr do
        order_id = generate_id
        result = @service.entry_tran_brandtoken({
          :order_id => order_id,
          :job_cd => "AUTH",
          :amount => 100
        })
        access_id = result["AccessID"]
        access_pass = result["AccessPass"]
        result = @service.exec_tran_brandtoken({
          :order_id    => order_id,
          :access_id   => access_id,
          :access_pass => access_pass,
          :token_type  => :apple_pay,
          :token       => 'base64encodedtoken',
          :client_field_1 => 'ｶｿｳｼﾃﾝ'
        })
        result["Status"].nil?.should_not be true
        result["OrderID"].nil?.should_not be true
        result["Forward"].nil?.should_not be true
        result["Approve"].nil?.should_not be true
        result["TranID"].nil?.should_not be true
        result["TranDate"].nil?.should_not be true
        result["ClientField1"].should eq "カソウシテン"
        result["ClientField1"].encoding.name.should eq "UTF-8"
        result["ClientField2"].nil?.should_not be true
        result["ClientField3"].nil?.should_not be true
      end
    end
  end

  describe "#alter_tran" do
    it "gets data about order", :vcr do
      order_id = generate_id
      result = @service.entry_tran({
        :order_id => order_id,
        :job_cd => "AUTH",
        :amount => 100
      })
      access_id = result["AccessID"]
      access_pass = result["AccessPass"]
      result = @service.exec_tran({
        :order_id      => order_id,
        :access_id     => access_id,
        :access_pass   => access_pass,
        :method        => 1,
        :pay_times     => 1,
        :card_no       => "4111111111111111",
        :expire        => "1405"
      })
      result = @service.alter_tran({
        :access_id      => access_id,
        :access_pass    => access_pass,
        :job_cd         => "RETURN",
        :amount         => 100
      })
      result["AccessID"].nil?.should_not be_truthy
      result["AccessPass"].nil?.should_not be_truthy
      result["Forward"].nil?.should_not be_truthy
      result["Approve"].nil?.should_not be_truthy
      result["AccessPass"].nil?.should_not be_truthy
      result["TranID"].nil?.should_not be_truthy
      result["TranDate"].nil?.should_not be_truthy
    end

    it "change order auth to sale", :vcr do
      order_id = generate_id
      result = @service.entry_tran({
        :order_id => order_id,
        :job_cd => "AUTH",
        :amount => 100
      })
      access_id = result["AccessID"]
      access_pass = result["AccessPass"]
      result = @service.exec_tran({
        :order_id      => order_id,
        :access_id     => access_id,
        :access_pass   => access_pass,
        :method        => 1,
        :pay_times     => 1,
        :card_no       => "4111111111111111",
        :expire        => "1405"
      })
      result = @service.alter_tran({
        :access_id      => access_id,
        :access_pass    => access_pass,
        :job_cd         => "SALES",
        :amount         => 100
      })
      result["AccessID"].nil?.should_not be_truthy
      result["AccessPass"].nil?.should_not be_truthy
      result["Forward"].nil?.should_not be_truthy
      result["Approve"].nil?.should_not be_truthy
      result["AccessPass"].nil?.should_not be_truthy
      result["TranID"].nil?.should_not be_truthy
      result["TranDate"].nil?.should_not be_truthy
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.alter_tran()
      }.should raise_error("Required access_id, access_pass, job_cd were not provided.")
    end
  end

  describe "#change_tran" do
    it "gets data about order", :vcr do
      order_id = generate_id
      result = @service.entry_tran({
        :order_id => order_id,
        :job_cd => "AUTH",
        :amount => 100
      })
      access_id = result["AccessID"]
      access_pass = result["AccessPass"]
      result = @service.exec_tran({
        :order_id      => order_id,
        :access_id     => access_id,
        :access_pass   => access_pass,
        :method        => 1,
        :pay_times     => 1,
        :card_no       => "4111111111111111",
        :expire        => "1405"
      })
      result = @service.change_tran({
        :access_id      => access_id,
        :access_pass    => access_pass,
        :job_cd         => "AUTH",
        :amount         => 1000
      })
      result["AccessID"].nil?.should_not be_truthy
      result["AccessPass"].nil?.should_not be_truthy
      result["Forward"].nil?.should_not be_truthy
      result["Approve"].nil?.should_not be_truthy
      result["TranID"].nil?.should_not be_truthy
      result["TranDate"].nil?.should_not be_truthy
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.change_tran()
      }.should raise_error("Required access_id, access_pass, job_cd, amount were not provided.")
    end
  end

  describe "#change_tran_brandtoken" do
    it "gets data about order", :vcr do
      order_id = generate_id
      result = @service.entry_tran_brandtoken({
        :order_id => order_id,
        :job_cd => "AUTH",
        :amount => 100
      })
      access_id = result["AccessID"]
      access_pass = result["AccessPass"]
      @service.exec_tran_brandtoken({
        :order_id    => order_id,
        :access_id   => access_id,
        :access_pass => access_pass,
        :token_type  => :apple_pay,
        :token       => 'base64encodedtoken'
      })
      result = @service.change_tran_brandtoken({
        :order_id    => order_id,
        :access_id   => access_id,
        :access_pass => access_pass,
        :job_cd      => "CAPTURE",
        :amount      => 1500
      })
      result["AccessID"].nil?.should_not be true
      result["AccessPass"].nil?.should_not be true
      result["Status"].nil?.should_not be true
      result["Forward"].nil?.should_not be true
      result["Approve"].nil?.should_not be true
      result["TranID"].nil?.should_not be true
      result["TranDate"].nil?.should_not be true
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.change_tran_brandtoken()
      }.should raise_error('Required access_id, access_pass, order_id, job_cd, amount were not provided.')
    end
  end

  describe "#void_tran_brandtoken" do
    it "gets data about order", :vcr do
      order_id = generate_id
      result = @service.entry_tran_brandtoken({
        :order_id => order_id,
        :job_cd => "AUTH",
        :amount => 100
      })
      access_id = result["AccessID"]
      access_pass = result["AccessPass"]
      @service.exec_tran_brandtoken({
        :order_id    => order_id,
        :access_id   => access_id,
        :access_pass => access_pass,
        :token_type  => :apple_pay,
        :token       => 'base64encodedtoken'
      })
      result = @service.void_tran_brandtoken({
        :order_id    => order_id,
        :access_id   => access_id,
        :access_pass => access_pass
      })
      result["AccessID"].nil?.should_not be true
      result["AccessPass"].nil?.should_not be true
      result["Status"].nil?.should_not be true
      result["Forward"].nil?.should_not be true
      result["Approve"].nil?.should_not be true
      result["TranID"].nil?.should_not be true
      result["TranDate"].nil?.should_not be true
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.void_tran_brandtoken()
      }.should raise_error('Required access_id, access_pass, order_id were not provided.')
    end
  end

  describe "#sales_tran_brandtoken" do
    it "gets data about a transaction", :vcr do
      order_id = generate_id
      result = @service.entry_tran_brandtoken({
        :order_id => order_id,
        :job_cd => "AUTH",
        :amount => 1000
      })
      access_id = result["AccessID"]
      access_pass = result["AccessPass"]
      @service.exec_tran_brandtoken({
        :order_id    => order_id,
        :access_id   => access_id,
        :access_pass => access_pass,
        :token_type  => :apple_pay,
        :token       => 'base64encodedtoken'
      })
      member_id = generate_id
      @shop_site.trade_brandtoken({
        :member_id => member_id,
        :order_id  => order_id
      })
      result = @service.sales_tran_brandtoken({
        :access_id   => access_id,
        :access_pass => access_pass,
        :order_id    => order_id,
        :amount      => 1000
      })
      result["AccessID"].nil?.should_not be true
      result["AccessPass"].nil?.should_not be true
      result["Status"].nil?.should_not be true
      result["Forward"].nil?.should_not be true
      result["Approve"].nil?.should_not be true
      result["TranID"].nil?.should_not be true
      result["TranDate"].nil?.should_not be true
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.sales_tran_brandtoken()
      }.should raise_error('Required access_id, access_pass, order_id, amount were not provided.')
    end
  end

  describe "#refund_tran_brandtoken" do
    it "gets data about a transaction", :vcr do
      order_id = generate_id
      result = @service.entry_tran_brandtoken({
        :order_id => order_id,
        :job_cd   => "CAPTURE",
        :amount   => 1000
      })
      access_id = result["AccessID"]
      access_pass = result["AccessPass"]
      @service.exec_tran_brandtoken({
        :order_id    => order_id,
        :access_id   => access_id,
        :access_pass => access_pass,
        :token_type  => :apple_pay,
        :token       => 'base64encodedtoken'
      })
      result = @service.refund_tran_brandtoken({
        :access_id   => access_id,
        :access_pass => access_pass,
        :order_id    => order_id,
        :amount      => 1000
      })
      result["AccessID"].nil?.should_not be true
      result["AccessPass"].nil?.should_not be true
      result["Status"].nil?.should_not be true
      result["Forward"].nil?.should_not be true
      result["Approve"].nil?.should_not be true
      result["TranID"].nil?.should_not be true
      result["TranDate"].nil?.should_not be true
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.refund_tran_brandtoken()
      }.should raise_error('Required access_id, access_pass, order_id, amount were not provided.')
    end
  end

  describe "#cvs_cancel" do
    it "gets data about a transaction", :vcr do
      order_id = generate_id
      result = @service.entry_tran_cvs({
        :order_id => order_id,
        :amount => 100
      })
      access_id = result["AccessID"]
      access_pass = result["AccessPass"]
      result = @service.cvs_cancel({
        :order_id => order_id,
        :access_id => access_id,
        :access_pass => access_pass,
      })

      result["OrderID"].nil?.should_not be_truthy
      result["Status"].nil?.should_not be_truthy
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.cvs_cancel()
      }.should raise_error("Required access_id, access_pass, order_id were not provided.")
    end
  end

  describe "#search_trade" do
    it "gets data about order", :vcr do
      order_id = @order_id
      result = @service.search_trade({
        :order_id => order_id
      })
      result["OrderID"].nil?.should_not be_truthy
      result["Status"].nil?.should_not be_truthy
      result["ProcessDate"].nil?.should_not be_truthy
      result["JobCd"].nil?.should_not be_truthy
      result["AccessID"].nil?.should_not be_truthy
      result["AccessPass"].nil?.should_not be_truthy
      result["ItemCode"].nil?.should_not be_truthy
      result["Amount"].nil?.should_not be_truthy
      result["Tax"].nil?.should_not be_truthy
      result["SiteID"].nil?.should_not be_truthy
      result["MemberID"].nil?.should_not be_truthy
      result["CardNo"].nil?.should_not be_truthy
      result["Expire"].nil?.should_not be_truthy
      result["Method"].nil?.should_not be_truthy
      result["PayTimes"].nil?.should_not be_truthy
      result["Forward"].nil?.should_not be_truthy
      result["TranID"].nil?.should_not be_truthy
      result["Approve"].nil?.should_not be_truthy
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.search_trade()
      }.should raise_error("Required order_id were not provided.")
    end
  end

  describe "#search_trade_multi" do
    it "gets data about order", :vcr do
      result = @service.search_trade_multi({
        :order_id      => @order_id,
        :pay_type      => "0"
      })
      result["Status"].nil?.should_not be_truthy
      result["ProcessDate"].nil?.should_not be_truthy
      result["JobCd"].nil?.should_not be_truthy
      result["AccessID"].nil?.should_not be_truthy
      result["AccessPass"].nil?.should_not be_truthy
      result["ItemCode"].nil?.should_not be_truthy
      result["Amount"].nil?.should_not be_truthy
      result["Tax"].nil?.should_not be_truthy
      result["SiteID"].nil?.should_not be_truthy
      result["MemberID"].nil?.should_not be_truthy
      result["CardNo"].nil?.should_not be_truthy
      result["Expire"].nil?.should_not be_truthy
      result["Method"].nil?.should_not be_truthy
      result["PayTimes"].nil?.should_not be_truthy
      result["Forward"].nil?.should_not be_truthy
      result["TranID"].nil?.should_not be_truthy
      result["Approve"].nil?.should_not be_truthy
      result["PayType"].nil?.should_not be_truthy
      result["PaymentTerm"].nil?.should_not be_truthy
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.search_trade_multi()
      }.should raise_error("Required order_id, pay_type were not provided.")
    end
  end

  describe "#exec_tran with 3DS2.0" do
    it "returns 3DS2.0 challenge flow response", :vcr do
      result = @service.exec_tran({
        :access_id => "test_access_7ed782e0e10604b31258e0d69ee3e887",
        :access_pass => "test_pass_7be5e8786e2e959d7b48ad708634dc7e",
        :order_id => "TEST_3DS_20250724231518",
        :method => 1,
        :pay_times => "",
        :card_no => "4111111111111111",
        :expire => "2512",
        :member_id => "TEST_MEMBER_5df458bc",
        :card_seq => 0,
        :tds_type => 2,
        :tds2_type => 2,
        :call_back_url => "https://example.com/callback",
        :tds2_ret_url => "https://example.com/3ds/return"
      })

      result["OrderID"].should == "<ORDER_ID>"
      result["Forward"].should == "<FORWARD>"
      result["Method"].should == "1"
      result["TranID"].should == "<TRAN_ID>"
      result["TranDate"].should == "<TRAN_DATE>"
      result["Tds2TransResult"].should == "C"
      result["Tds2TransResultReason"].should == "01"
      result["Tds2ChallengeUrl"].should include("/payment/Tds2Challenge")
      result["Tds2TransID"].should == "<TDS2_TRANS_ID>"
    end
  end

  describe "#tds2_auth" do
    it "executes 3DS2.0 authentication", :vcr do
      result = @service.tds2_auth({
        :access_id => "test_access_7ed782e0e10604b31258e0d69ee3e887",
        :access_pass => "test_pass_7be5e8786e2e959d7b48ad708634dc7e",
        :tds2_param => "dummy_tds2_param"
      })

      result["OrderID"].should == "<ORDER_ID>"
      result["Forward"].should == "<FORWARD>"
      result["Method"].should == "1"
      result["PayTimes"].should == ""
      result["Approve"].should == ""
      result["TranID"].should == "<TRAN_ID>"
      result["TranDate"].should == "<TRAN_DATE>"
      result["CheckString"].should == "<CHECK_STRING>"
      result["Tds2TransResult"].should == "Y"  # Authentication successful
      result["Tds2TransResultReason"].should == ""
      result["Tds2ChallengeUrl"].should_not be_nil
      result["Tds2ChallengeUrl"].should include("/payment/Tds2Challenge")
    end
  end

  describe "#tds2_result" do
    it "gets 3DS2.0 authentication result", :vcr do
      result = @service.tds2_result({
        :access_id => "test_access_7ed782e0e10604b31258e0d69ee3e887",
        :access_pass => "test_pass_7be5e8786e2e959d7b48ad708634dc7e"
      })

      result["OrderID"].should == "<ORDER_ID>"
      result["Forward"].should == "<FORWARD>"
      result["Method"].should == "1"
      result["PayTimes"].should == ""
      result["Approve"].should == ""
      result["TranID"].should == "<TRAN_ID>"
      result["TranDate"].should == "<TRAN_DATE>"
      result["CheckString"].should == "<CHECK_STRING>"
      result["Tds2TransResult"].should == "Y"  # Authentication successful
      result["Tds2TransResultReason"].should == ""
    end
  end

  describe "#secure_tran_2" do
    it "completes payment after 3DS2.0 challenge verification", :vcr do
      result = @service.secure_tran_2({
        :access_id => "test_access_7ed782e0e10604b31258e0d69ee3e887",
        :access_pass => "test_pass_7be5e8786e2e959d7b48ad708634dc7e"
      })

      result["OrderID"].should == "<ORDER_ID>"
      result["Forward"].should == "<FORWARD>"
      result["Method"].should == "1"
      result["PayTimes"].should == ""
      result["Approve"].should == "<APPROVE>"
      result["TranID"].should == "<TRAN_ID>"
      result["TranDate"].should == "<TRAN_DATE>"
      result["CheckString"].should == "<CHECK_STRING>"
    end
  end
end
