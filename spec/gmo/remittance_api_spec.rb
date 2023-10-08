# Encoding: UTF-8

require "spec_helper"

describe "GMO::Payment::RemittanceAPI" do

  before(:each) do
    @service ||= GMO::Payment::RemittanceAPI.new({
      :shop_id   => SPEC_CONF["remittance"]["shop_id"],
      :shop_pass => SPEC_CONF["remittance"]["shop_pass"],
      :host      => SPEC_CONF["remittance"]["host"],
      :locale    => :ja

    })
  end

  it "should raise an ArgumentError if no options passed" do
    lambda {
      service = GMO::Payment::RemittanceAPI.new()
    }.should raise_error(ArgumentError)
  end

  it "has an attr_reader for shop_id" do
    @service.shop_id.should == SPEC_CONF["remittance"]["shop_id"]
  end

  it "has an attr_reader for shop_pass" do
    @service.shop_pass.should == SPEC_CONF["remittance"]["shop_pass"]
  end

  it "has an attr_reader for host" do
    @service.host.should == SPEC_CONF["remittance"]["host"]
  end

  describe "#create_account" do
    let(:do_api_call) {
      @service.create_account({
        :bank_id           => "bank00001",
        :bank_code         => "0001",
        :branch_code       => "813",
        :account_type      => :normal,
        :account_name      => "An Yutzy",
        :account_number    => "0012345",
        :branch_code_jp    => "00567",
        :account_number_jp => "01234567",
        :free              => "foobar"
      })
    }

    it "gets data about an account", :vcr do
      result = do_api_call
      result["Bank_ID"].nil?.should_not be_truthy
      result["Method"].nil?.should_not be_truthy
    end

    context 'with all required options' do
      let(:response) { OpenStruct.new(status: 200, body: nil ) }
      before { allow(GMO).to receive(:make_request) { response } }

      it "makes request with correct parameters", :vcr do
        path = "/api/AccountRegistration.idPass"
        args = {
          "Method"                => 1,
          "Bank_ID"               => "bank00001",
          "Bank_Code"             => "0001",
          "Branch_Code"           => "813",
          "Account_Type"          => 1,
          "Account_Name"          => "An Yutzy",
          "Account_Number"        => "0012345",
          "Branch_Code_Jpbank"    => "00567",
          "Account_Number_Jpbank" => "01234567",
          "Free"                  => "foobar",
          "Shop_ID"               => @service.shop_id,
          "Shop_Pass"             => @service.shop_pass
        }
        verb = "post"
        options = { :host => @service.host }
        expect(GMO).to receive(:make_request).with(path, args, verb, options)
      end

      after { do_api_call }
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.create_account()
      }.should raise_error("Required bank_id, bank_code, branch_code, account_type, account_name, account_number were not provided.")
    end
  end

  describe "#update_account" do
    let(:do_api_call) {
      @service.update_account({
        :bank_id           => "bank00001",
        :bank_code         => "0001",
        :branch_code       => "813",
        :account_type      => :normal,
        :account_name      => "An Yutzy",
        :account_number    => "0012345",
        :branch_code_jp    => "00567",
        :account_number_jp => "01234567",
        :free              => "foobar"
      })
    }

    it "gets data about an account", :vcr do
      result = do_api_call
      result["Bank_ID"].nil?.should_not be_truthy
      result["Method"].nil?.should_not be_truthy
    end

    context 'with all required options' do
      let(:response) { OpenStruct.new(status: 200, body: nil ) }
      before { allow(GMO).to receive(:make_request) { response } }

      it "makes request with correct parameters", :vcr do
        path = "/api/AccountRegistration.idPass"
        args = {
          "Method"                => 2,
          "Bank_ID"               => "bank00001",
          "Bank_Code"             => "0001",
          "Branch_Code"           => "813",
          "Account_Type"          => 1,
          "Account_Name"          => "An Yutzy",
          "Account_Number"        => "0012345",
          "Branch_Code_Jpbank"    => "00567",
          "Account_Number_Jpbank" => "01234567",
          "Free"                  => "foobar",
          "Shop_ID"               => @service.shop_id,
          "Shop_Pass"             => @service.shop_pass
        }
        verb = "post"
        options = { :host => @service.host }
        expect(GMO).to receive(:make_request).with(path, args, verb, options)
      end

      after { do_api_call }
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.create_account()
      }.should raise_error("Required bank_id, bank_code, branch_code, account_type, account_name, account_number were not provided.")
    end
  end

  describe "#delete_account" do
    let(:do_api_call) { @service.delete_account(bank_id: "bank00001") }

    it "gets data about an account", :vcr do
      result = do_api_call
      result["Bank_ID"].nil?.should_not be_truthy
      result["Method"].nil?.should_not be_truthy
    end

    context 'with all required options' do
      let(:response) { OpenStruct.new(status: 200, body: nil ) }
      before { allow(GMO).to receive(:make_request) { response } }

      it "makes request with correct parameters", :vcr do
        path = "/api/AccountRegistration.idPass"
        args = {
          "Method"                => 3,
          "Bank_ID"               => "bank00001",
          "Shop_ID"               => @service.shop_id,
          "Shop_Pass"             => @service.shop_pass
        }
        verb = "post"
        options = { :host => @service.host }
        expect(GMO).to receive(:make_request).with(path, args, verb, options)
      end

      after { do_api_call }
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.delete_account()
      }.should raise_error("Required bank_id were not provided.")
    end
  end

  describe "#search_account" do
    let(:do_api_call) { @service.search_account(:bank_id => "bank00001") }

    it "gets data about an account", :vcr do
      result = do_api_call
      result["Bank_ID"].nil?.should_not be_truthy
      result["Delete_Flag"].nil?.should_not be_truthy
      result["Bank_Name"].nil?.should_not be_truthy
      result["Bank_Code"].nil?.should_not be_truthy
      result["Branch_Name"].nil?.should_not be_truthy
      result["Branch_Code"].nil?.should_not be_truthy
      result["Account_Type"].nil?.should_not be_truthy
      result["Account_Number"].nil?.should_not be_truthy
      result["Account_Name"].nil?.should_not be_truthy
      result["Free"].nil?.should_not be_truthy
      result["Branch_Code_Jpbank"].nil?.should_not be_truthy
      result["Account_Number_Jpbank"].nil?.should_not be_truthy
    end

    context 'with all required options' do
      let(:response) { OpenStruct.new(status: 200, body: nil ) }
      before { allow(GMO).to receive(:make_request) { response } }

      it "makes request with correct parameters", :vcr do
        path = "/api/AccountSearch.idPass"
        args = {
          "Bank_ID"   => "bank00001",
          "Shop_ID"   => @service.shop_id,
          "Shop_Pass" => @service.shop_pass
        }
        verb = "post"
        options = { :host => @service.host }
        expect(GMO).to receive(:make_request).with(path, args, verb, options)
      end

      after { do_api_call }
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.search_account()
      }.should raise_error("Required bank_id were not provided.")
    end
  end

  describe "#create_deposit" do
    let(:do_api_call) {
      @service.create_deposit({
        :bank_id    => "bank00001",
        :deposit_id => "dep00001",
        :amount     => "1000"
      })
    }

    it "gets data about a deposit", :vcr do
      result = do_api_call
      result["Bank_ID"].nil?.should_not be_truthy
      result["Deposit_ID"].nil?.should_not be_truthy
      result["Method"].nil?.should_not be_truthy
      result["Amount"].nil?.should_not be_truthy
      result["Bank_Fee"].nil?.should_not be_truthy
    end

    context 'with all required options' do
      let(:response) { OpenStruct.new(status: 200, body: nil ) }
      before { allow(GMO).to receive(:make_request) { response } }

      it "makes request with correct parameters", :vcr do
        path = "/api/DepositRegistration.idPass"
        args = {
          "Method"     => 1,
          "Bank_ID"    => "bank00001",
          "Deposit_ID" => "dep00001",
          "Amount"     => "1000",
          "Shop_ID"    => @service.shop_id,
          "Shop_Pass"  => @service.shop_pass
        }
        verb = "post"
        options = { :host => @service.host }
        expect(GMO).to receive(:make_request).with(path, args, verb, options)
      end

      after { do_api_call }
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.create_deposit()
      }.should raise_error("Required bank_id, deposit_id, amount were not provided.")
    end
  end

  describe "#cancel_deposit" do
    let(:do_api_call) {
      @service.cancel_deposit({
        :bank_id    => "bank00001",
        :deposit_id => "dep00001",
      })
    }

    it "gets data about a deposit", :vcr do
      result = do_api_call
      result["Bank_ID"].nil?.should_not be_truthy
      result["Deposit_ID"].nil?.should_not be_truthy
      result["Method"].nil?.should_not be_truthy
    end

    context 'with all required options' do
      let(:response) { OpenStruct.new(status: 200, body: nil ) }
      before { allow(GMO).to receive(:make_request) { response } }

      it "makes request with correct parameters", :vcr do
        path = "/api/DepositRegistration.idPass"
        args = {
          "Method"     => 2,
          "Bank_ID"    => "bank00001",
          "Deposit_ID" => "dep00001",
          "Shop_ID"    => @service.shop_id,
          "Shop_Pass"  => @service.shop_pass
        }
        verb = "post"
        options = { :host => @service.host }
        expect(GMO).to receive(:make_request).with(path, args, verb, options)
      end

      after { do_api_call }
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.cancel_deposit()
      }.should raise_error("Required bank_id, deposit_id were not provided.")
    end
  end

  describe "#search_deposit" do
    let(:do_api_call) { @service.search_deposit(:deposit_id => "dep00001") }

    it "gets data about a deposit", :vcr do
      result = do_api_call
      result["Bank_ID"].nil?.should_not be_truthy
      result["Deposit_ID"].nil?.should_not be_truthy
      result["Bank_Name"].nil?.should_not be_truthy
      result["Bank_Code"].nil?.should_not be_truthy
      result["Branch_Name"].nil?.should_not be_truthy
      result["Branch_Code"].nil?.should_not be_truthy
      result["Account_Type"].nil?.should_not be_truthy
      result["Account_Number"].nil?.should_not be_truthy
      result["Account_Name"].nil?.should_not be_truthy
      result["Free"].nil?.should_not be_truthy
      result["Amount"].nil?.should_not be_truthy
      result["Bank_Fee"].nil?.should_not be_truthy
      result["Result"].nil?.should_not be_truthy
      result["Branch_Code_Jpbank"].nil?.should_not be_truthy
      result["Account_Number_Jpbank"].nil?.should_not be_truthy
      result["Deposit_Date"].nil?.should_not be_truthy
      result["Result_Detail"].nil?.should_not be_truthy
    end

    context 'with all required options' do
      let(:response) { OpenStruct.new(status: 200, body: nil ) }
      before { allow(GMO).to receive(:make_request) { response } }

      it "makes request with correct parameters", :vcr do
        path = "/api/DepositSearch.idPass"
        args = {
          "Deposit_ID" => "dep00001",
          "Shop_ID"    => @service.shop_id,
          "Shop_Pass"  => @service.shop_pass
        }
        verb = "post"
        options = { :host => @service.host }
        expect(GMO).to receive(:make_request).with(path, args, verb, options)
      end

      after { do_api_call }
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.search_deposit()
      }.should raise_error("Required deposit_id were not provided.")
    end
  end

  describe "#search_balance" do
    let(:do_api_call) { @service.search_balance }
    it "gets data about balance", :vcr do
      result = do_api_call
      result["Shop_ID"].nil?.should_not be_truthy
      result["Balance"].nil?.should_not be_truthy
      result["Balance_Forecast"].nil?.should_not be_truthy
    end
  end

  describe "#create_mail_deposit" do
    subject(:do_api_call) { @service.create_mail_deposit(options) }

    context 'with valid options', :vcr do
      let(:options) do
        {
          :deposit_id           => "dep00001",
          :deposit_email        => "anyutzy@demo.com",
          :amount               => 1000,
          :deposit_account_name => "An Yutzy",
          :expire               => 5,
          :deposit_shop_email   => "anyutzy@demo.com",
          :auth_code            => "auth00001",
          :auth_code_2          => "auth00002",
          :auth_code_3          => "auth00003",
          :remit_method_bank    => "1",
          :mail_template_free_1 => "mail_template_free_1",
          :mail_template_free_2 => "mail_template_free_2",
          :mail_template_free_3 => "mail_template_free_3",
          :mail_template_number => 1,
          :bank_id              => "bank_id00001",
          :select_key           => "select00001",
          :client_name          => "イライニンタロウ",
        }
      end

      before { allow(GMO).to receive(:make_request).and_call_original }

      it "gets data about a mail deposit" do
        result = do_api_call
        expect(result["Deposit_ID"]).to eq options[:deposit_id]
        expect(result["Method"]).to eq "1"
        expect(result["Amount"]).to eq options[:amount].to_s
        expect(result["Expire"]).not_to be_nil
      end

      it "makes request with correct parameters" do
        do_api_call
        path = "/api/MailDepositRegistration.idPass"
        args = {
          "Deposit_ID"                => options[:deposit_id],
          "Mail_Address"              => options[:deposit_email],
          "Amount"                    => options[:amount],
          "Mail_Deposit_Account_Name" => options[:deposit_account_name],
          "Expire"                    => options[:expire],
          "Shop_Mail_Address"         => options[:deposit_shop_email],
          "Auth_Code"                 => options[:auth_code],
          "Auth_Code2"                => options[:auth_code_2],
          "Auth_Code3"                => options[:auth_code_3],
          "Remit_Method_Bank"         => options[:remit_method_bank],
          "Mail_Template_Free1"       => options[:mail_template_free_1],
          "Mail_Template_Free2"       => options[:mail_template_free_2],
          "Mail_Template_Free3"       => options[:mail_template_free_3],
          "Mail_Template_Number"      => options[:mail_template_number],
          "Bank_ID"                   => options[:bank_id],
          "Select_Key"                => options[:select_key],
          "Client_Name"               => options[:client_name],
          "Method"                    => 1,
          "Shop_ID"                   => @service.shop_id,
          "Shop_Pass"                 => @service.shop_pass
        }
        expect(GMO).to have_received(:make_request).with(path, args, "post", { :host => @service.host })
      end
    end

    context "with invalid options" do
      let(:options) { {} }

      it "got error" do
        expect { do_api_call }.to raise_error("Required deposit_id, deposit_email, amount, expire, deposit_shop_email were not provided.")
      end
    end
  end

  describe "#cancel_mail_deposit" do
    let(:do_api_call) { @service.cancel_mail_deposit(deposit_id: "dep00001") }

    it "gets data about a mail deposit", :vcr do
      result = do_api_call
      result["Deposit_ID"].nil?.should_not be_truthy
      result["Method"].nil?.should_not be_truthy
    end

    context 'with all required options' do
      let(:response) { OpenStruct.new(status: 200, body: nil ) }
      before { allow(GMO).to receive(:make_request) { response } }

      it "makes request with correct parameters", :vcr do
        path = "/api/MailDepositRegistration.idPass"
        args = {
          "Deposit_ID"                => "dep00001",
          "Method"                    => 2,
          "Shop_ID"                   => @service.shop_id,
          "Shop_Pass"                 => @service.shop_pass
        }
        verb = "post"
        options = { :host => @service.host }
        expect(GMO).to receive(:make_request).with(path, args, verb, options)
      end

      after { do_api_call }
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.cancel_mail_deposit()
      }.should raise_error("Required deposit_id were not provided.")
    end
  end

  describe "#search_mail_deposit" do
    let(:do_api_call) { @service.search_mail_deposit(deposit_id: "dep00001") }

    it "gets data about a mail deposit", :vcr do
      result = do_api_call
      result["Deposit_ID"].nil?.should_not be_truthy
      result["Mail_Address"].should eq('anyutzy+test@demo.com')
      result["Shop_Mail_Address"].nil?.should_not be_truthy
      result["Account_Name"].nil?.should_not be_truthy
      result["Amount"].nil?.should_not be_truthy
      result["Expire"].nil?.should_not be_truthy
      result["Status"].nil?.should_not be_truthy
    end

    context 'with all required options' do
      let(:response) { OpenStruct.new(status: 200, body: nil ) }
      before { allow(GMO).to receive(:make_request) { response } }

      it "makes request with correct parameters", :vcr do
        path = "/api/MailDepositSearch.idPass"
        args = {
          "Deposit_ID" => "dep00001",
          "Shop_ID"    => @service.shop_id,
          "Shop_Pass"  => @service.shop_pass
        }
        verb = "post"
        options = { :host => @service.host }
        expect(GMO).to receive(:make_request).with(path, args, verb, options)
      end

      after { do_api_call }
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.search_mail_deposit()
      }.should raise_error("Required deposit_id were not provided.")
    end
  end

  describe "#create_link_redirect_url" do
    subject(:do_api_call) { @service.create_link_redirect_url(options) }

    context 'with valid options', :vcr do
      let(:deposit_id) { "dep00001" }
      let(:options) do
        {
          deposit_id: deposit_id,
          call_back_url: "https://example.com/callback",
          amount: "1000",
          auth_code: "auth00005",
          auth_code_2: "auth00002",
          auth_code_3: "auth00003",
          remit_method_bank: "1",
          remit_method_sevenatm: "1",
          sevenatm_payment_term_day: "15",
          remit_method_amazongift: "1",
          remit_method_aupay: "1",
          bank_id: "bank_id00001",
          client_name: "リンクユーアールエル",
        }
      end

      it "gets data about link redirect url" do
        result = do_api_call
        expect(result["Deposit_ID"]).to eq(deposit_id)
        expect(result["Redirect_Url"]).not_to be_nil
        expect(result["Method"]).to eq("1")
      end
    end

    context "with invalid options", :vcr do
      let(:options) { {} }

      it "got error" do
        expect { do_api_call }.to raise_error("Required deposit_id, call_back_url, amount, auth_code were not provided.")
      end
    end
  end

  describe "#cancel_link_redirect_url" do
    subject (:do_api_call) { @service.cancel_link_redirect_url(options) }

    before { @service.create_link_redirect_url(deposit_id: deposit_id, call_back_url: 'https://example.com/callback', amount: '100', auth_code: 'AUTH001') }

    context 'with valid options', :vcr do
      let(:options) { { deposit_id: deposit_id } }
      let(:deposit_id) { "dep00001" }

      it "gets data about a link edirect url" do
        result = do_api_call
        expect(result["Deposit_ID"]).not_to be_nil
        expect(result["Method"]).to eq "2"
      end
    end

    context "with invalid options", :vcr do
      let(:options) { {} }
      let(:deposit_id) { "dep00001" }

      it "got error" do
        expect { do_api_call }.to raise_error("Required deposit_id were not provided.")
      end
    end
  end
end
