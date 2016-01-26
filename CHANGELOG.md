# CHANGELOG

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