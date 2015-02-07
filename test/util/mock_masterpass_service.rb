module Mastercard
  module Masterpass
    class MockMasterpassService < Mastercard::Masterpass::MasterpassService
      def get_payment_shipping_resource(checkout_resource_url, access_token)
        return "<?xml version='1.0' encoding='UTF-8'?><Checkout><Card><BrandId>master</BrandId><BrandName>MasterCard</BrandName><AccountNumber>5453010000064154</AccountNumber><BillingAddress><City>Niagara falls</City><Country>CA</Country><CountrySubdivision>CA-ON</CountrySubdivision><Line1>5943 Victoria Ave</Line1><Line2/><PostalCode>L2G 3L7</PostalCode></BillingAddress><CardHolderName>JOE Test</CardHolderName><ExpiryMonth>5</ExpiryMonth><ExpiryYear>2017</ExpiryYear></Card><TransactionId>2031782</TransactionId><Contact><FirstName>JOE</FirstName><LastName>Test</LastName><Country>US</Country><EmailAddress>joe.test@email.com</EmailAddress><PhoneNumber>1-9876543210</PhoneNumber></Contact><ShippingAddress><City>Seattle</City><Country>US</Country><CountrySubdivision>US-WA</CountrySubdivision><Line1>1326 5th Ave SE</Line1><Line2/><PostalCode>98101</PostalCode><RecipientName>JOE  Test</RecipientName><RecipientPhoneNumber>1-2061113333</RecipientPhoneNumber></ShippingAddress><PayPassWalletIndicator>101</PayPassWalletIndicator></Checkout>"
      end
    end
  end
end