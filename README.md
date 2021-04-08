# Instamojo

Will use to integrate instomojo apis with ruby. Will support ruby 2.0 or newver, autotags

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'instamojo'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install instamojo

## Usage

add following code to config/intializer/instamojo.rb

```ruby
  Instamojo.configure do |config|
    config.client_id = 'XXXX'
    config.client_secret = 'XXXXXXX'
    config.mode = :test
  end

```

## Development

  ### Sign up method

```ruby
  options = {
    username: 'xxx', # manadatory
    email: 'xxx@xxx.xxx', # manadatory
    password: 'xxxxx233xxx', # manadatory
    phone: 'xxxxxxxxx', # manadatory
    referrer: 'xxxxx'
  }
  api.signup(options)
```


   ### Generate User Token

```ruby
   options = {
      username: 'xxx', # manadatory
      password: 'xxxxx233xxx', # manadatory
   }
    api.user_token(options)
```


   ### Update Bank Details

```ruby
   options = {
    account_holder_name: 'xxx', # manadatory
    account_number: '998799899', # manadatory
    ifsc_code: 'JUUJU9889'
   }

   user_id # manadatory
   api.inrbankaccount(user_id, options)
```


  ### Create Payment Link

```ruby
   options = {
     'amount': '2500', # mandatory
     'purpose': 'FIFA 16', # mandatory
     'buyer_name': 'John Doe', # mandatory
     'email': 'foo@example.com',
     'phone': '9999999999',
     'redirect_url': 'http://www.example.com/redirect/',
     'send_email': 'True',
     'send_sms': 'True',
     'webhook': 'http://www.example.com/webhook/'
     'allow_repeated_payments': 'False',
   }
   api.payment_link(options)
```

### API Doc

```ruby
{
   "id":"bf9d8993-83e1-5687-3c4a-3b9ac8c25fc1",
   "name":"auth-flow-integration",
   "description":"",
   "order":[
      "bb1ab458-c149-34fb-9b07-95952eac3f0f",
      "3fefebf2-9f92-bda5-c6cc-67d4cbc9a2ee",
      "2229fdf6-6d19-fc9c-510b-1a39f0caba02",
      "2cda24d7-aab9-fba0-0db7-33dc744e5bc8",
      "284c2f07-2a18-b340-9114-ffe88d99f425",
      "3f4938b7-7a0b-8254-19ab-ed553f955151"
   ],
   "folders":[

   ],
   "timestamp":1444030167485,
   "owner":"47402",
   "remoteLink":"",
   "public":false,
   "requests":[
      {
         "collectionId":"bf9d8993-83e1-5687-3c4a-3b9ac8c25fc1",
         "id":"2229fdf6-6d19-fc9c-510b-1a39f0caba02",
         "name":"Get User Token",
         "description":"### Get User Access Token\n\nUse this to get an User access token. You will need it to modify of a user on Instamojo.\n\nThe expiry time for an user access token is `36000` seconds.\n\nA user token will have a refresh token associated with it. So if a user token expires, you can use the refresh token along with your client_id and client_secret to get a new user access token.\n\n##### Field validations\n1. `grant_type`: `client_credentials`\n2. `username`: Mandatory. Username of the user.\n3. `password`: Mandatory. Password of the user.\n4. `client_id`: Mandatory. You Instamojo client_id.\n5. `client_secret`: Mandatory. Your Instamojo client_secret.\n",
         "url":"{{AUTH_SERVER}}/oauth2/token/",
         "method":"POST",
         "headers":"",
         "data":[
            {
               "key":"grant_type",
               "value":"password",
               "type":"text",
               "enabled":true
            },
            {
               "key":"client_id",
               "value":"{{CLIENT_ID}}",
               "type":"text",
               "enabled":true
            },
            {
               "key":"client_secret",
               "value":"{{CLIENT_SECRET}}",
               "type":"text",
               "enabled":true
            },
            {
               "key":"username",
               "value":"{{USERNAME}}",
               "type":"text",
               "enabled":true
            },
            {
               "key":"password",
               "value":"{{PASSWORD}}",
               "type":"text",
               "enabled":true
            }
         ],
         "dataMode":"params",
         "responses":[

         ],
         "version":2
      },
      {
         "collectionId":"bf9d8993-83e1-5687-3c4a-3b9ac8c25fc1",
         "id":"284c2f07-2a18-b340-9114-ffe88d99f425",
         "name":"Update bank details",
         "description":"## Add / Update the Bank Details\n\n\nPayouts will be sent/processed to this bank account.\n\n#### Field validations\n\n1. `account_holder_name` - Mandatory.  Maxlength=100\n2. `account_number` - Mandatory. Maxlength=50, Digits only.\n3. `ifsc_code` - Mandatory, Exact length=11, First 4 alpha, 5th 0, remaining alpha numeric. Ex: `SBIN0123456`",
         "url":"{{API_SERVER}}/v2/users/{{USER_ID}}/inrbankaccount/",
         "method":"PUT",
         "headers":"Authorization: Bearer {{USER_ACCESS_TOKEN}}\n",
         "data":[
            {
               "key":"account_holder_name",
               "value":"Foo Bar",
               "type":"text",
               "enabled":true
            },
            {
               "key":"account_number",
               "value":"123456789",
               "type":"text",
               "enabled":true
            },
            {
               "key":"ifsc_code",
               "value":"SBIN0123456",
               "type":"text",
               "enabled":true
            }
         ],
         "dataMode":"params",
         "responses":[

         ],
         "version":2
      },
      {
         "collectionId":"bf9d8993-83e1-5687-3c4a-3b9ac8c25fc1",
         "id":"2cda24d7-aab9-fba0-0db7-33dc744e5bc8",
         "name":"Update Name and Location of a User",
         "description":"### Update User information\n\n##### Validations\n1. `first_name` - Optional. Maxlength=30\n2. `last_name` - Optional. Maxlength=30\n3. `location` - Optional. Maxlenth=100. Location in text format. Ex: Mumbai, India",
         "url":"{{API_SERVER}}/v2/users/{{USER_ID}}",
         "method":"PATCH",
         "headers":"Authorization: Bearer {{USER_ACCESS_TOKEN}}\n",
         "data":[
            {
               "key":"first_name",
               "value":"Foo",
               "type":"text",
               "enabled":true
            },
            {
               "key":"last_name",
               "value":"Bar",
               "type":"text",
               "enabled":true
            },
            {
               "key":"location",
               "value":"India",
               "type":"text",
               "enabled":true
            }
         ],
         "dataMode":"params",
         "responses":[

         ],
         "version":2
      },
      {
         "collectionId":"bf9d8993-83e1-5687-3c4a-3b9ac8c25fc1",
         "id":"3f4938b7-7a0b-8254-19ab-ed553f955151",
         "name":"Get User Token from Refresh Token",
         "description":"### Get User token from Refresh token\n\nIf you already have a user access token for a specific user, but the token has expired, use this to fetch a fresh access token. \n\nWhen you use this, you wont need the user's credentials again. Send the refresh_token instead. \n\nAlso, note that the `grant_type` in this case is `refresh_token`.\n\n###### Field validations\n1. `grant_type`: `refresh_token`\n2. `refresh_token`: Mandatory. The refresh token.\n3. `client_id`: Mandatory. You Instamojo client_id.\n4. `client_secret`: Mandatory. Your Instamojo client_secret.",
         "url":"{{AUTH_SERVER}}/oauth2/token/",
         "method":"POST",
         "headers":"",
         "data":[
            {
               "key":"grant_type",
               "value":"refresh_token",
               "type":"text",
               "enabled":true
            },
            {
               "key":"client_id",
               "value":"{{CLIENT_ID}}",
               "type":"text",
               "enabled":true
            },
            {
               "key":"client_secret",
               "value":"{{CLIENT_SECRET}}",
               "type":"text",
               "enabled":true
            },
            {
               "key":"refresh_token",
               "value":"IHbzz97XePGwX3VBGaVlOdGOxfGHWJ",
               "type":"text",
               "enabled":true
            }
         ],
         "dataMode":"params",
         "responses":[

         ],
         "version":2
      },
      {
         "collectionId":"bf9d8993-83e1-5687-3c4a-3b9ac8c25fc1",
         "id":"3fefebf2-9f92-bda5-c6cc-67d4cbc9a2ee",
         "name":"Signup",
         "description":"### Sign up users\n\n#####Field Validations\n1. `username`: Mandatory. `Maxlength` = `35 chars`.\n2. `password`: Mandatory.\n3. `email`: Mandatory.\n4. `phone`: Mandatory\n4. `referrer`: `shopo`",
         "url":"{{API_SERVER}}/v2/users/",
         "method":"POST",
         "headers":"Authorization: Bearer {{APP_ACCESS_TOKEN}}\n",
         "data":[
            {
               "key":"username",
               "value":"dhanush_5oct13",
               "type":"text"
            },
            {
               "key":"password",
               "value":"abcd1234",
               "type":"text"
            },
            {
               "key":"email",
               "value":"dhanush+5oct13@instamojo.com",
               "type":"text"
            },
            {
               "key":"phone",
               "value":"+918748984861",
               "type":"text"
            },
            {
               "key":"referrer",
               "value":"shopo",
               "type":"text"
            }
         ],
         "dataMode":"params",
         "timestamp":0,
         "version":2,
         "time":1444116541552
      },
      {
         "collectionId":"bf9d8993-83e1-5687-3c4a-3b9ac8c25fc1",
         "id":"bb1ab458-c149-34fb-9b07-95952eac3f0f",
         "name":"Get App Token",
         "description":"### Get an app access token\n\nUse this to get an App access token. You will need it to sign up users on Instamojo.\n\nThe expiry time for a app access token is `36000` seconds.\n\nAn app token wont have any refresh token associated to it. So if an app access token expires, you will have to resend this request again. \n\n##### Field validations\n1. `grant_type`: `client_credentials`\n2. `client_id`: Mandatory. You Instamojo client_id.\n3. `client_secret`: Mandatory. Your Instamojo client_secret.",
         "url":"{{AUTH_SERVER}}/oauth2/token/",
         "method":"POST",
         "headers":"",
         "data":[
            {
               "key":"grant_type",
               "value":"client_credentials",
               "type":"text",
               "enabled":true
            },
            {
               "key":"client_id",
               "value":"{{CLIENT_ID}}",
               "type":"text",
               "enabled":true
            },
            {
               "key":"client_secret",
               "value":"{{CLIENT_SECRET}}",
               "type":"text",
               "enabled":true
            }
         ],
         "dataMode":"params",
         "responses":[

         ],
         "version":2
      }
   ]
}
```

## Payment API

```ruby
{
   "id":"cffc6b9e-ab1c-4ba3-411d-fd45c38f671f",
   "name":"RAP V2",
   "timestamp":1444044417026,
   "requests":[
      {
         "collectionId":"cffc6b9e-ab1c-4ba3-411d-fd45c38f671f",
         "id":"40564e31-10c1-0e71-1f2a-e40560b81dcb",
         "name":"RAP details",
         "description":"Get the details of a payment request using the payment_request_id",
         "url":"{{API_SERVER}}/v2/payment_requests/{{PAYMENT_REQUEST_ID}}",
         "method":"GET",
         "headers":"Authorization: Bearer {{USER_ACCESS_TOKEN}\n",
         "data":[
            {
               "key":"amount",
               "value":"2500",
               "type":"text"
            },
            {
               "key":"purpose",
               "value":"FIFA 16",
               "type":"text"
            },
            {
               "key":"send_sms",
               "value":"True",
               "type":"text"
            },
            {
               "key":"phone",
               "value":"9999999999",
               "type":"text"
            }
         ],
         "dataMode":"params",
         "timestamp":0,
         "version":2,
         "time":1444116919416
      },
      {
         "collectionId":"cffc6b9e-ab1c-4ba3-411d-fd45c38f671f",
         "id":"48d9c02b-6884-3596-2735-6584c181875b",
         "name":"RAP creation with send_sms",
         "description":"If 'send_sms' field is passed as True then 'phone' field is compulsory.",
         "url":"{{API_SERVER}}/v2/payment_requests/",
         "method":"POST",
         "headers":"Authorization: Bearer {{USER_ACCESS_TOKEN}\n",
         "data":[
            {
               "key":"amount",
               "value":"2500",
               "type":"text"
            },
            {
               "key":"purpose",
               "value":"FIFA 16",
               "type":"text"
            },
            {
               "key":"send_sms",
               "value":"True",
               "type":"text"
            },
            {
               "key":"phone",
               "value":"9999999999",
               "type":"text"
            }
         ],
         "dataMode":"params",
         "timestamp":0,
         "version":2,
         "time":1444116914545
      },
      {
         "collectionId":"cffc6b9e-ab1c-4ba3-411d-fd45c38f671f",
         "id":"69d60626-2572-44ad-daa3-96ee2a6a5f12",
         "name":"RAP creation minimal data",
         "description":"Amount and purpose are the only compulsory fields for creating a request payment.",
         "url":"{{API_SERVER}}/v2/payment_requests/",
         "method":"POST",
         "headers":"Authorization: Bearer {{USER_ACCESS_TOKEN}\n",
         "data":[
            {
               "key":"amount",
               "value":"2500",
               "type":"text"
            },
            {
               "key":"purpose",
               "value":"FIFA 16",
               "type":"text"
            }
         ],
         "dataMode":"params",
         "timestamp":0,
         "version":2,
         "time":1444116823741
      },
      {
         "collectionId":"cffc6b9e-ab1c-4ba3-411d-fd45c38f671f",
         "id":"891e3ec0-9c39-c7c1-c5e8-b0a4f4ea6924",
         "name":"RAP creation with maximal data",
         "description":"This request contains all of the fields that we can pass with a payment request creation.",
         "url":"{{API_SERVER}}/v2/payment_requests/",
         "method":"POST",
         "headers":"Authorization: Bearer {{USER_ACCESS_TOKEN}\n",
         "data":[
            {
               "key":"amount",
               "value":"2500",
               "type":"text"
            },
            {
               "key":"purpose",
               "value":"FIFA 16",
               "type":"text"
            },
            {
               "key":"send_sms",
               "value":"True",
               "type":"text"
            },
            {
               "key":"send_email",
               "value":"True",
               "type":"text"
            },
            {
               "key":"phone",
               "value":"9999999999",
               "type":"text"
            },
            {
               "key":"email",
               "value":"foo@example.com",
               "type":"text"
            },
            {
               "key":"buyer_name",
               "value":"John Doe",
               "type":"text"
            },
            {
               "key":"redirect_url",
               "value":"http://www.example.com/redirect/",
               "type":"text"
            },
            {
               "key":"webhook",
               "value":"http://www.example.com/webhook/",
               "type":"text"
            },
            {
               "key":"allow_repeated_payments",
               "value":"False",
               "type":"text"
            }
         ],
         "dataMode":"params",
         "timestamp":0,
         "version":2,
         "time":1444116905712
      },
      {
         "collectionId":"cffc6b9e-ab1c-4ba3-411d-fd45c38f671f",
         "id":"ff1f35b0-77d0-6a25-dadc-4fbba09073cf",
         "name":"RAP creation with send_email",
         "description":"If 'send_email' field is passed as True then 'email' field is compulsory.",
         "url":"{{API_SERVER}}/v2/payment_requests/",
         "method":"POST",
         "headers":"Authorization: Bearer {{USER_ACCESS_TOKEN}\n",
         "data":[
            {
               "key":"amount",
               "value":"2500",
               "type":"text"
            },
            {
               "key":"purpose",
               "value":"FIFA 16",
               "type":"text"
            },
            {
               "key":"send_email",
               "value":"True",
               "type":"text"
            },
            {
               "key":"email",
               "value":"foo@example.com",
               "type":"text"
            }
         ],
         "dataMode":"params",
         "timestamp":0,
         "version":2,
         "time":1444116910314
      }
   ]
}
```

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/zambrevishal/instamojo/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
