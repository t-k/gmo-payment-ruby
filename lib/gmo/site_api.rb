# coding: utf-8

# A client for the GMO Payment API.
#
# example
# gmo = GMO::Payment::SiteAPI.new({
#   site_id:     "foo",
#   site_pass:   "bar",
#   host:  "mul-pay.com"
# })
# result = gmo.post_request("EntryTran.idPass", options)
module GMO
  module Payment

    module SiteAPIMethods

      def initialize(options = {})
        @site_id   = options[:site_id]
        @site_pass = options[:site_pass]
        @host      = options[:host]
        unless @site_id && @site_pass && @host
          raise ArgumentError, "Initialize must receive a hash with :site_id, :site_pass and either :host! (received #{options.inspect})"
        end
      end
      attr_reader :site_id, :site_pass, :host

      ## 2.3.2.1.会員登録
      # 指定されたサイトに会員を登録します。
      def save_member(options = {})
        name = "SaveMember.idPass"
        required = [:member_id]
        assert_required_options(required, options)
        post_request name, options
      end

      ## 2.4.2.1.会員更新
      # 指定されたサイトに会員情報を更新します。
      def update_member(options = {})
        name = "UpdateMember.idPass"
        required = [:member_id]
        assert_required_options(required, options)
        post_request name, options
      end

      ## 2.5.2.1.会員削除
      # 指定したサイトから会員情報を削除します。
      def delete_member(options = {})
        name = "DeleteMember.idPass"
        required = [:member_id]
        assert_required_options(required, options)
        post_request name, options
      end

      ## 2.6.2.1.会員参照
      # 指定したサイトの会員情報を参照します。
      def search_member(options = {})
        name = "SearchMember.idPass"
        required = [:member_id]
        assert_required_options(required, options)
        post_request name, options
      end

      ## 2.7.2.1.カード登録/更新
      # 指定した会員にカード情報を登録します。尚、サイトに設定されたショップ ID を使用してカード会社と通信を行い有効性の確認を行います。
      def save_card(options = {})
        name = "SaveCard.idPass"
        required = [:member_id, :card_no, :expire]
        assert_required_options(required, options)
        post_request name, options
      end

      ## 2.8.2.1.カード削除
      # 指定した会員のカード情報を削除します。
      def delete_card(options = {})
        name = "DeleteCard.idPass"
        required = [:member_id, :card_seq]
        assert_required_options(required, options)
        post_request name, options
      end

      ## 2.9.2.1.カード参照
      # 指定した会員のカード情報を参照します。
      # /payment/SearchCard.idPass
      def search_card(options = {})
        name = "SearchCard.idPass"
        required = [:member_id, :seq_mode]
        assert_required_options(required, options)
        post_request name, options
      end

      ## 2.11.2.3. 決済実行
      # お客様が選択したカード登録連番のカード情報を取得します。
      # カード情報が本人認証サービスに対応していない場合は、カード会社との通信を行い決済を実行します。その際の出力パラメータは「2.10.2.3決済実行」の出力パラメータと同じになります。
      # /payment/ExecTran.idPass
      def exec_tran(options = {})
        name = "ExecTran.idPass"
        required = [:access_id, :access_pass, :order_id, :member_id, :card_seq]
        assert_required_options(required, options)
        post_request name, options
      end

      private

        def api_call(name, args = {}, verb = "post", options = {})
          args.merge!({ "SiteID" => @site_id, "SitePass" => @site_pass })
          response = api(name, args, verb, options) do |response|
            if response.is_a?(Hash) && !response["ErrInfo"].nil?
              raise APIError.new(response)
            end
          end
          response
        end

    end

  end
end