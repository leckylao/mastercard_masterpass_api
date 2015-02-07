require "mastercard_api"
require "test/unit"
require "mastercard_masterpass_api"
require "yaml"
require_relative '../test/util/test_utils'
require_relative '../test/util/mock_masterpass_service'


class MasterpassServiceTest < Test::Unit::TestCase
    def setup
       
       settings = TestUtils.new.get_settings
       @consumer_key = settings['CONSUMER_KEY']
       #puts "Key: #{TestUtils.new.get_private_key}"
       @service = Mastercard::Masterpass::MasterpassService.new(@consumer_key, TestUtils.new.get_private_key, "http://projectabc.com", Mastercard::Common::SANDBOX)
       @mock_service = Mastercard::Masterpass::MockMasterpassService.new(@consumer_key, TestUtils.new.get_private_key, "http://projectabc.com", Mastercard::Common::SANDBOX)
       @request_url = settings['REQUEST_URL']
       @shoppingcart_url = settings['SHOPPING_CART_URL']
       @access_url = settings['ACCESS_URL']
       @postback_url = settings['POSTBACK_URL']
       @pre_checkout_url = settings['PRE_CHECKOUT_URL']
       @express_checkout_url = settings['EXPRESS_CHECKOUT_URL']
       @merchant_init_url = settings['MERCHANT_INIT_URL']
       @pairing_callback_path = settings['PAIRING_CALLBACK_PATH']
       
       @callback_domain = settings['CALLBACK_DOMAIN']
       @callback_path = settings['CALLBACK_PATH']
       @callback_url = @callback_domain + @callback_path

       @consumer_key  = settings['CONSUMER_KEY']
       @checkout_identifier = settings['CHECKOUT_IDENTIFIER']

       @realm_type = settings['REALM']  

       @shipping_profiles = settings['SHIPPING_PROFILES'].split(",")
       
       @keystore_path =  settings['KEYSTORE_PATH']
       @keystore_password = settings['KEYSTORE_PASSWORD']
       @auth_level_basic = settings['AUTH_LEVEL_BASIC']
       @xml_version = settings['XML_VERSION']
       @shipping_suppression = settings['SHIPPING_SUPPRESSION']

       @requestVerifier = ""
       @checkoutResourceUrl = ""
       @signatureBaseString = ""
       
       @request_token_response = @service.get_request_token("https://sandbox.api.mastercard.com/oauth/consumer/v1/request_token", "http://projectabc.com/oauth").oauth_token 
       
    end
    
    def test_constructor
       assert @service != nil , "Test constructor"
    end
    
    def test_get_request_token_response
       response = @service.get_request_token(@request_url, @callback_url)
       assert_kind_of Mastercard::Masterpass::RequestTokenResponse, response, "Should return a RequestTokenResponse"
       assert response.oauth_token != nil && response.oauth_callback_confirmed == "true" && response.oauth_expires_in == "900" &&              "Test Request Token Response data"
       #puts "\nGET REQ TOKEN RESPONSE: \n #{response}\n"
    end
    
    def test_get_access_token_response
      token_response = @service.get_request_token(@request_url, @callback_url)
      #puts token_response.oauth_token
      response = @service.get_access_token(@access_url, token_response.oauth_token, "")
      assert_kind_of Mastercard::Masterpass::AccessTokenResponse, response, "Should return an AccessTokenResponse"
    end
    
    def test_post_shopping_cart_data
      shopping_cart_xml = TestUtils.new.get_shopping_cart_xml(@request_token_response, @callback_domain).to_s
      response = @service.post_shopping_cart_data(@shoppingcart_url, shopping_cart_xml)
      #puts"\nSHOPPING CART RESPONSE: \n#{response}"
      assert response != nil, "Shopping Cart response shouldn't be nil"
    end
    
    def test_post_merchant_init
      merchant_init_xml = TestUtils.new.get_merchant_init_xml(@request_token_response, @callback_domain).to_s
      #puts "MERCHANT INIT URL:\n#{@merchant_init_url}"
      #puts merchant_init_xml
      response = @service.post_merchant_init_data(@merchant_init_url, merchant_init_xml)
      #puts"\nMERCAHANT INIT RESPONSE: \n#{response}"
      assert response != nil, "Merchant Init response shouldn't be nil"
    end
    
    def test_get_payment_shipping_resource
      response = @mock_service.get_payment_shipping_resource("abc", "123")
      assert response != nil, "payment shipping resource shouldn't be nil"
    end
    
end