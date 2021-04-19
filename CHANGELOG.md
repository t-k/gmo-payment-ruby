# CHANGELOG

## 0.5.3
* Support 認証後決済実行 [#45](https://github.com/t-k/gmo-payment-ruby/pull/45) (Thanks [@darren987469](https://github.com/darren987469))
* Support SearchType of INPUT_PARAMS [#47](https://github.com/t-k/gmo-payment-ruby/pull/47) (Thanks [@nkuroda](https://github.com/nkuroda))
* Drop ruby 2.0.0 [#48](https://github.com/t-k/gmo-payment-ruby/pull/48)

## 0.5.2
* Support d払い/ドコモ払い(docomo payment), 楽天ペイ(Rakuten payment) [#42](https://github.com/t-k/gmo-payment-ruby/pull/42) (Thanks [@valda](https://github.com/valda))
* Add more G-series error codes [#41](https://github.com/t-k/gmo-payment-ruby/pull/41) (Thanks [@ermaac](https://github.com/ermaac))

## 0.5.1
* Add more error codes [#37](https://github.com/t-k/gmo-payment-ruby/pull/37) (Thanks [@jagdeepsingh](https://github.com/jagdeepsingh))

## 0.5.0
* Support CvsCancel API  [#34](https://github.com/t-k/gmo-payment-ruby/pull/34) (Thanks [@mogulla3](https://github.com/mogulla3 ))
* Fix typo [#29](https://github.com/t-k/gmo-payment-ruby/pull/29) (Thanks [@nishio-dens](https://github.com/nishio-dens))
* Support PaymentType of INPUT_PARAMS [#28](https://github.com/t-k/gmo-payment-ruby/pull/28) (Thanks [@johnny-miyake](https://github.com/johnny-miyake))

## 0.4.0

* Multipayment API
  * Add end points to manage brandtoken [#22](https://github.com/t-k/gmo-payment-ruby/pull/22) (Thanks [@jagdeepsingh](https://github.com/JagdeepSingh))
  * Add end points to make payments and refunds using brandtoken [#22](https://github.com/t-k/gmo-payment-ruby/pull/22) (Thanks [@jagdeepsingh](https://github.com/JagdeepSingh))

* RemittanceAPI
  * Add support to register payment accounts [#20](https://github.com/t-k/gmo-payment-ruby/pull/20) (Thanks [@jagdeepsingh](https://github.com/JagdeepSingh))
  * Add support to register deposits [#20](https://github.com/t-k/gmo-payment-ruby/pull/20) (Thanks [@jagdeepsingh](https://github.com/JagdeepSingh))
  * Add support to register mail deposits [#20](https://github.com/t-k/gmo-payment-ruby/pull/20) (Thanks [@jagdeepsingh](https://github.com/JagdeepSingh))

* Add error messages to GMO API response along with error code and info [#20](https://github.com/t-k/gmo-payment-ruby/pull/20) (Thanks [@jagdeepsingh](https://github.com/JagdeepSingh))

* SiteAPI
  * Add support to search card detail by member_id [#21](https://github.com/t-k/gmo-payment-ruby/pull/21) (Thanks  [@tkiha](https://github.com/tkiha))

* ShopAPI
  * Add token payment support #23 (Thanks @k0uki)

## 0.3.0
 * ShopAPI
   * Support LINE Pay payment #13 (Thanks @ryooob)

     ShopAPI#entry_tran_linepay, ShopAPI#exec_tran_linepay were added
   * Update required item on ShopAPI#exec_tran_cvs #15 (Thanks @pyonnuka)
 * SiteAPI
   * card_no and expire are not required for save_card if a token is used #17 (Thanks @mcfiredrill)
 * Testing
   * fix Spec and upgrade RSpec to v3 #14, #16, #18, #19 (Thanks @htz @cameluby @kazuooooo @mcfiredrill)

## 0.2.6
 * Fixes several Ruby warnings #8 (Thanks @amatsuda)

## 0.2.5
 * Support Pay-easy payment #7 (Thanks @ryooob)

## 0.2.4
 * Fix SiteAPI search_card required params (:card_seq is not required field)
 * Some refactoring

## 0.2.3
 * Added module GMO::JSON to blur the differences between the different MultiJson
 * Added test for ShopAndSiteAPI#trade_card
 * Fix typo and comment #4, #3 (Thanks @toshiwo, @fukayatsu)

## 0.2.2
 * Changed POST data encoding to Shift-JIS #2 (Thanks @keichan34)

## 0.2.1
 * Fix handling of ClientField options on GMO::Payment::ShopAPI#exec_tran

## 0.2.0

 * Use https scheme for rubygems source
 * Add support for required fields validation
 * Adds pay-by-Konbini support (Thanks @keichan34)
