# UKMail

Ruby wrapper for UK Mail (a.k.a. DHL Parcel UK) SOAP API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'uk_mail'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install uk_mail

## Usage

### - Configure

Add your UK Mail postcode file to the gem configuration along with an environment option:

```ruby
UKMail.configure do |config|
  config.postcode_data_path = 'path/to/my/postcode_file.dat')
  config.env = # :production or :test
end
```

### - Authenticate

Logging in to UK Mail will give you an authentication token and a list of accounts.
You should store the token and reuse it until it expires.

Create a session:

```ruby
# If you have an authentication token already:

session = UKMail::Session.new(token)

# If not:

session = UKMail::Session.new
response = session.login(username, password)

# Store these values somewhere.
response.authenticationToken
response.accounts
```

### - List domestic services

The method below will return a list of services with a `name` and `key`. The key
will be used to create a consignment later.

```ruby
UKMail::DomesticServices.list(parcel_type, delivery_type, country, county, postcode)

# Example:

UKMail::DomesticService.list(
	'Bagit Medium',
	'Signature Service to the specified address only',
	'Ireland',
	'Cork',
	'ABC 123'
)
```

See `lib/uk_mail/domestic_services.yml` for a full list of parcel and delivery types.

The `country` and `county` args are required only for Ireland.

International and Packets services do not need to be filtered in this way. Their
names and codes can be found in the API documentation.

### - Book a collection

Get a collection job number. This should be done only once per day.

Using a session (see 'Authenticate' above):

```ruby
collection_service = ::UKMail::Service::Collection.new(session)

response = collection_service.book_collection(
  username: ''
  account_number: ''
  closed_for_lunch: ''
  earliest_time: ''
  latest_time: ''
  requested_collection_date: ''
  special_instructions: ''
)

# Store this value somewhere.
response.collectionJobNumber
```

See the API documentation for details on the above parameters.

### - Create a consignment

Get a consignment number and shipping label.

Using a session and collection job number (see 'Authenticate' and 'Book a collection' above):

```ruby
service = ::UKMail::Service::Consignment.new(session)

# Domestic:
response = service.add_domestic_consignment(
  username: '',
  collection_job_number: '',
  account_number: '',
  contact_name: '',
  business_name: '',
  address: {
    address_1: '',
    address_2: '',
    address_3: '',
    postal_town: '',
    county: '',
    postcode: '',
    country_code: '',
  },
  email: '',
  telephone: '',
  customers_ref: '',
  alternative_ref: '',
  items: '',
  service_key: '',
  special_instructions_1: '',
  special_instructions_2: '',
  confirmation_of_delivery: '',
  pre_delivery_notification: '',
  weight: '',
  confirmation_email: '',
  confirmation_telephone: '',
  exchange_on_delivery: '',
  extended_cover: '',
  signature_optional: '',
  secure_location_1: '',
  secure_location_2: '',
  book_in: '',
  cod_amount: '',
  long_length: ''
)

# International:
response = service.add_international_consignment(
  username: '',
  collection_job_number: '',
  account_number: '',
  contact_name: '',
  business_name: '',
  address: {
    address_1: '',
    address_2: '',
    address_3: '',
    postal_town: '',
    county: '',
    postcode: '',
    country_code: '',
  },
  email: '',
  telephone: '',
  customers_ref: '',
  alternative_ref: '',
  items: '',
  service_key: '',
  special_instructions_1: '',
  special_instructions_2: '',
  confirmation_of_delivery: '',
  weight: '',
  currency_code: '',
  documents_only: '',
  extended_cover_required: '',
  goods_description_1: '',
  in_free_circulation_eu: '',
  invoice_type: '',
  no_dangerous_goods: '',
  value: '',
  goods_description_2: '',
  goods_description_3: '',
  height: '',
  length: '',
  width: ''
)

# Packets:
response = service.add_packets_consignment(
  username: '',
  collection_job_number: '',
  account_number: '',
  contact_name: '',
  business_name: '',
  address: {
    address_1: '',
    address_2: '',
    address_3: '',
    postal_town: '',
    county: '',
    postcode: '',
    country_code: '',
  },
  email: '',
  telephone: '',
  customers_ref: '',
  alternative_ref: '',
  items: '',
  service_key: '',
  special_instructions_1: '',
  special_instructions_2: '',
  confirmation_of_delivery: '',
  weight_in_grams: '',
  packet_length: '',
  packet_width: '',
  packet_height: '',
  delivery_message_1: '',
  delivery_message_2: ''
)

# The response contains a consignment number and an array of Base64-encoded labels.
# The label data may need to be decoded twice.
response.consignmentNumber
response.labels

```

See the API documentation for details on the above parameters.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/uk_mail/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
