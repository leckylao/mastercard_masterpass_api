require 'rexml/document'
require 'rexml/text' 

class TestUtils
  include REXML
  
  @settings
  
  def initialize
    get_settings
  end
  
  def get_private_key
    OpenSSL::PKCS12.new(File.open(@settings["KEYSTORE_PATH"]),@settings["KEYSTORE_PASSWORD"]).key
  end
  
  def get_settings
     @settings = Hash.new
     env_file = File.join('test', 'util', 'config.yml')
     YAML.load(File.open(env_file)).each do |key, value|
       @settings[key.to_s] = value
     end if File.exists?(env_file)
     return @settings
  end
  
  def get_shopping_cart_xml(request_token, origin_url)
      file = File.open( 'data/shoppingCart.xml', 'r' )
      doc = REXML::Document.new file
      doc.root.elements['OAuthToken'].add_text(request_token)
      doc.root.add_element('OriginUrl').add_text(origin_url)
      file.close
      return doc
  end
  
  def get_merchant_init_xml(request_token, origin_url)
    file = File.open('data/merchantInit.xml', 'r')
    doc = REXML::Document.new file
    doc.root.elements['OAuthToken'].add_text(request_token)
    doc.root.elements['OriginUrl'].add_text(origin_url)
    file.close
    return doc
  end
  
  def get_precheckout_data_xml
    file = File.open('data/preCheckoutRequest.xml', 'r')
    doc = REXML::Document.new file
    file.close
    return doc
  end
end

