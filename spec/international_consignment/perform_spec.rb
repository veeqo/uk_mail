require 'spec_helper'

describe UKMail::InternationalConsignment, '.perform' do
  subject { described_class.perform(params) }

  let(:api_key) { ENV['TEST_API_KEY'] }

  let(:params) do
    {
      userName: ENV['TEST_USERNAME'],
      authenticationToken: ENV['TEST_AUTH_TOKEN'],
      api_key: api_key,
      accountNumber: 'K806570',
      collectionInfo: {
        collectionJobNumber: 'MK449040608',
        collectionDate: Time.new(2020,11,6,10,0).utc.strftime("%Y-%m-%d")
      },
      delivery: {
        localContactName: 'John Smith',
        localContactNumber: '01234 567890',
        contactNumberType: 'mobile',
        localContactEmail: 'johnsmith@example.com',
        deliveryAddresses: [
          {
            businessName: nil, # optional
            address1: 'Josef-Dey-Weg 36',
            address2: nil, # optional
            address3: nil, # optional
            postalTown: 'Frankfurt',
            County: 'Hesse', # optional
            zipcode: '65929',
            countryCode: 'DEU',
            addressType: 'doorstep',
            servicePointId: nil, # optional
          }
        ]
      },
      serviceKey: '204',
      items: 1,
      customerReference: nil, # optional
      alternativeReference: nil, # optional
      parcels: [ # Exactly 1
        {
          length: 20,
          width: 15,
          height: 10,
          weight: '1.50'
        }
      ],
      extendedCoverRequired: false,
      customsDeclaration: {
        full: {
          invoiceType: 'commercial',
          invoiceNumber: 'G2389-121',
          invoiceDate: Time.now.strftime('%Y-%m-%d'),
          articles: {
            article: [
              {
                commodityCode: '84733092',
                goodsDescription: 'Computer parts',
                quantity: 1,
                unitValue: '56.20',
                unitWeight: '1.50',
                countryofManufacture: 'USA'
              }
            ]
          },
          totalArticles: 1,
          shippingCharges: 12,
          totalValue: '56.20', # optional
          currencyCode: 'GBP', # optional
          reasonForExport: 'commercial sale',
          termsOfDelivery: 'DAP',
        },
      },
      recipient: {
        contactName: 'John Smith',
        contactEmail: 'johnsmith@exmaple.com',
        contactNumber: '01234 567890', # optional
        taxReference: '12345123451234', # optional
        recipientAddress: {
          businessName: nil, # optional
          address1: 'Josef-Dey-Weg 36',
          address2: nil, # optional
          address3: nil, # optional
          postalTown: 'Frankfurt',
          County: 'Hesse', # optional
          zipcode: '65929',
          countryCode: 'DEU',
          addressType: 'residential',
        }
      },
      inBoxReturn: false, # optional
      inBoxReturnDetail: nil, # optional
      InvoiceRequired: false,
      LabelFormat: 'PDF200dpi6x4'
    }
  end

  context 'with valid inputs', vcr: { cassette_name: 'international_consignment/perform/success' } do
    it 'makes the consignment and returns a ConsignmentResponse with number and labels' do
      expect(subject).to be_a(UKMail::ConsignmentResponse)

      expect(subject.consignment_number).to eq('71007060057679')

      expect(subject.labels).to be_an(Array)
      expect(subject.labels[0]).to start_with('%PDF')
      expect(subject.invoice).to start_with('%PDF')
    end
  end

  context 'with an invalid auth token', vcr: { cassette_name: 'international_consignment/perform/invalid_auth_token' } do
    before { params[:authenticationToken] = 'expired_token' }

    it 'raises an AuthTokenError' do
      expect{subject}.to raise_error(UKMail::AuthTokenError)
    end
  end

  context 'with some missing inputs', vcr: { cassette_name: 'international_consignment/perform/missing_inputs' } do
    before do
      params[:userName] = ''
      params[:accountNumber] = ''
    end

    it 'raises a UKMailError with a relevant message' do
      expect{subject}.to raise_error(UKMail::UKMailError, "The UserName field is required.\nThe AccountNumber field is required.")
    end
  end

  context 'with an invalid API key', vcr: { cassette_name: 'international_consignment/perform/invalid_api_key' } do
    let(:api_key) { '' }

    it 'raises a UKMailError with a relevant message' do
      expect{subject}.to raise_error(UKMail::UKMailError, 'API key is invalid.')
    end
  end
end
