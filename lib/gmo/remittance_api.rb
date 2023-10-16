# coding: utf-8

# A client for the GMO Remittance API.
#
# example
# gmo = GMO::Payment::RemittanceAPI.new({
#   shop_id:     "foo",
#   shop_pass:   "bar",
#   host:        "test-remittance.gmopg.jp",
#   locale:      "ja"
# })
module GMO
  module Payment

    module RemittanceAPIMethods

      def initialize(options = {})
        @shop_id   = options[:shop_id]
        @shop_pass = options[:shop_pass]
        @host      = options[:host]
        @locale    = options.fetch(:locale, GMO::Const::DEFAULT_LOCALE)
        unless @shop_id && @shop_pass && @host
          raise ArgumentError, "Initialize must receive a hash with :shop_id, :shop_pass and either :host! (received #{options.inspect})"
        end
      end
      attr_reader :shop_id, :shop_pass, :host, :locale

      #########
      # Method
      # Bank_ID
      # Bank_Code
      # Branch_Code
      # Account_Type
      # Account_Name
      # Account_Number
      # Branch_Code_Jpbank
      # Account_Number_Jpbank
      # Free
      ### @return ###
      # Bank_ID
      # Method
      # ErrCode
      # ErrInfo
      ### example ###
      # gmo.create_account({
      #   bank_id:           'bank00000',
      #   bank_code:         '0001',
      #   branch_code:       '813',
      #   account_type:      :normal,
      #   account_name:      'An Yutzy',
      #   account_number:    '0012345',
      #   branch_code_jp:    '00567',
      #   account_number_jp: '01234567',
      #   free:              'foobar'      # Metadata
      # })
      # {"Bank_ID"=>"bank00000", "Method"=>"1"}
      def create_account(options = {})
        name = "/api/AccountRegistration.idPass"
        options[:method] = 1
        options[:account_type] = GMO::Const::ACCOUNT_TYPES_MAP[options[:account_type]]
        required = %i(bank_id bank_code branch_code account_type account_name account_number)
        assert_required_options(required, options)
        post_request name, options
      end

      #########
      # Method
      # Bank_ID
      # Bank_Code
      # Branch_Code
      # Account_Type
      # Account_Name
      # Account_Number
      # Branch_Code_Jpbank
      # Account_Number_Jpbank
      # Free
      ### @return ###
      # Bank_ID
      # Method
      # ErrCode
      # ErrInfo
      ### example ###
      # gmo.update_account({
      #   bank_id:           'bank00000',
      #   bank_code:         '0001',
      #   branch_code:       '813',
      #   account_type:      :normal,
      #   account_name:      'An Yutzy',
      #   account_number:    '0012345',
      #   branch_code_jp:    '00567',
      #   account_number_jp: '01234567',
      #   free:              'foobar'      # Metadata
      # })
      # {"Bank_ID"=>"bank00000", "Method"=>"2"}
      def update_account(options = {})
        name = "/api/AccountRegistration.idPass"
        options[:method] = 2
        options[:account_type] = GMO::Const::ACCOUNT_TYPES_MAP[options[:account_type]]
        required = %i(bank_id bank_code branch_code account_type account_name account_number)
        assert_required_options(required, options)
        post_request name, options
      end

      #########
      # Method
      # Bank_ID
      ### @return ###
      # Bank_ID
      # Method
      # ErrCode
      # ErrInfo
      ### example ###
      # gmo.delete_account({
      #   bank_id: 'bank00000',
      # })
      # {"Bank_ID"=>"bank00000", "Method"=>"3"}
      def delete_account(options = {})
        name = "/api/AccountRegistration.idPass"
        options[:method] = 3
        required = %i(bank_id)
        assert_required_options(required, options)
        post_request name, options
      end

      #########
      # Bank_ID
      ### @return ###
      # Bank_ID
      # Delete_Flag
      # Bank_Name
      # Bank_Code
      # Branch_Name
      # Branch_Code
      # Account_Type
      # Account_Number
      # Account_Name
      # Free
      # Branch_Code_Jpbank
      # Account_Number_Jpbank
      ### example ###
      # gmo.search_account({
      #   bank_id: 'bank12345'
      # })
      # {"Bank_ID"=>"bank12345", "Delete_Flag"=>"0", "Bank_Name"=>"みずほ銀行", "Bank_Code"=>"0001", "Branch_Name"=>"札幌支店", "Branch_Code"=>"813", "Account_Type"=>"1", "Account_Number"=>"0012345", "Account_Name"=>"An Yutzy", "Free"=>"", "Branch_Code_Jpbank"=>"", "Account_Number_Jpbank"=>""}
      def search_account(options = {})
        name = "/api/AccountSearch.idPass"
        required = %i(bank_id)
        assert_required_options(required, options)
        post_request name, options
      end

      #########
      # Method
      # Deposit_ID
      # Bank_ID
      # Amount
      ### @return ###
      # Deposit_ID
      # Bank_ID
      # Method
      # Amount
      # Bank_Fee
      ### example ###
      # gmo.create_deposit({
      #   deposit_id: 'dep00000',
      #   bank_id:    'bank00000',
      #   amount:     '1000'
      # })
      # {"Deposit_ID"=>"dep00000", "Bank_ID"=>"bank00000", "Method"=>"1", "Amount"=>"1000", "Bank_Fee"=>"27"}
      def create_deposit(options = {})
        name = "/api/DepositRegistration.idPass"
        options[:method] = 1
        required = %i(bank_id deposit_id amount)
        assert_required_options(required, options)
        post_request name, options
      end

      #########
      # Method
      # Deposit_ID
      # Bank_ID
      ### @return ###
      # Deposit_ID
      # Bank_ID
      # Method
      ### example ###
      # gmo.cancel_deposit({
      #   deposit_id: 'dep00000',
      #   bank_id:    'bank00000',
      # })
      # {"Deposit_ID"=>"dep00000", "Bank_ID"=>"bank00000", "Method"=>"2"}
      def cancel_deposit(options = {})
        name = "/api/DepositRegistration.idPass"
        options[:method] = 2
        required = %i(bank_id deposit_id)
        assert_required_options(required, options)
        post_request name, options
      end

      #############
      # Deposit_ID
      ### @return ###
      # Deposit_ID
      # Bank_ID
      # Bank_Name
      # Bank_Code
      # Branch_Name
      # Branch_Code
      # Account_Type
      # Account_Number
      # Account_Name
      # Free
      # Amount
      # Bank_Fee
      # Result
      # Branch_Code_Jpbank
      # Account_Number_Jpbank
      # Deposit_Date
      # Result_Detail
      ### example ###
      # gmo.search_deposit({
      #   deposit_id: 'dep00000'
      # })
      # {"Deposit_ID"=>"dep00000", "Bank_ID"=>"bank163144", "Bank_Name"=>"みずほ銀行", "Bank_Code"=>"0001", "Branch_Name"=>"札幌支店", "Branch_Code"=>"813", "Account_Type"=>"1", "Account_Number"=>"0012345", "Account_Name"=>"An Yutzy", "Free"=>"", "Amount"=>"181035", "Bank_Fee"=>"270", "Result"=>"0", "Branch_Code_Jpbank"=>"", "Account_Number_Jpbank"=>"", "Deposit_Date"=>"", "Result_Detail"=>""}
      def search_deposit(options = {})
        name = "/api/DepositSearch.idPass"
        required = %i(deposit_id)
        assert_required_options(required, options)
        post_request name, options
      end

      #########
      ### @return ###
      # Shop_ID
      # Balance
      # Balance_Forecast
      ### example ###
      # gmo.search_balance
      # {"Shop_ID"=>"rshop00000071", "Balance"=>"9818965", "Balance_Forecast"=>"9818965"}
      def search_balance(options = {})
        name = "/api/BalanceSearch.idPass"
        post_request name, options
      end

      ###########
      # Method
      # Deposit_ID
      # Mail_Address
      # Amount
      # Mail_Deposit_Account_Name
      # Expire
      # Shop_Mail_Address
      # Auth_Code
      # Auth_Code2
      # Auth_Code3
      # Remit_Method_Bank
      # Mail_Template_Free1
      # Mail_Template_Free2
      # Mail_Template_Free3
      # Mail_Template_Number
      # Bank_ID
      # Select_Key
      # Client_Name
      ### @return ###
      # Method
      # Amount
      # Deposit_ID
      # Expire
      ### example ###
      # gmo.create_mail_deposit({
      #   deposit_id: 'dep00001',
      #   deposit_email: 'anyutzy@demo.com',
      #   amount: 1000,
      #   deposit_account_name: 'An Yutzy',
      #   expire: 5,
      #   deposit_shop_email: 'anyutzy@demo.com'
      # })
      # {"Deposit_ID"=>"dep00009", "Method"=>"1", "Amount"=>"1200", "Expire"=>"20170503"}
      def create_mail_deposit(options = {})
        name = "/api/MailDepositRegistration.idPass"
        options[:method] = 1
        required = %i(deposit_id deposit_email amount expire deposit_shop_email)
        assert_required_options(required, options)
        post_request name, options
      end

      ###########
      # Method
      # Deposit_ID
      ### @return ###
      # Deposit_ID
      # Method
      ### example ###
      # gmo.cancel_mail_deposit({
      #   deposit_id: 'dep00001',
      # })
      # {"Deposit_ID"=>"dep00001", "Method"=>"2"}
      def cancel_mail_deposit(options = {})
        name = "/api/MailDepositRegistration.idPass"
        options[:method] = 2
        required = %i(deposit_id)
        assert_required_options(required, options)
        post_request name, options
      end

      #########
      # Deposit_ID
      ### @return ###
      # Deposit_ID
      # Mail_Address
      # Shop_Mail_Address
      # Account_Name
      # Amount
      # Expire
      # Status
      ### example ###
      # gmo.search_mail_deposit({
      #   deposit_id: 'dep00001'
      # })
      # {"Deposit_ID"=>"dep0001516", "Mail_Address"=>"anyutzy@demo.com", "Shop_Mail_Address"=>"anyutzy@demo.com", "Account_Name"=>"An Yutzy", "Amount"=>"1000", "Expire"=>"20170503", "Status"=>"0"}
      def search_mail_deposit(options = {})
        name = "/api/MailDepositSearch.idPass"
        required = %i(deposit_id)
        assert_required_options(required, options)
        post_request name, options
      end

      private

        def api_call(name, args = {}, verb = "post", options = {})
          args.merge!({ "Shop_ID" => @shop_id, "Shop_Pass" => @shop_pass })
          api(name, args, verb, options) do |response|
            if response.is_a?(Hash) && !response["ErrInfo"].nil?
              raise APIError.new(response, locale)
            end
          end
        end

    end

  end
end
