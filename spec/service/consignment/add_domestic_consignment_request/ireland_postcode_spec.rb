require 'spec_helper'

describe UKMail::Service::Consignment::AddDomesticConsignmentRequest, '#ireland_postcode' do
  let(:request) { UKMail::Service::Consignment::AddDomesticConsignmentRequest.new(nil, params) }
  let(:params) do
    {
      address: {
        county: county,
        postcode: postcode
      }
    }
  end

  shared_examples_for 'correct conversion' do
    it 'returns the expected result' do
      expect(subject).to eq(expected_result)
    end

    it 'does not add any validation errors' do
      expect{subject}.not_to change{request.validation_errors}
    end
  end

  shared_examples_for 'invalid input' do
    it 'returns the expected result' do
      expect(subject).to eq(expected_result)
    end

    it 'adds one or more validation errors' do
      expect{subject}.to change{request.validation_errors}.from({})
    end
  end

  subject { request.ireland_postcode }

  context 'when the county does not exist' do
    let(:county) { 'notrealcounty' }
    let(:postcode) { nil }

    it 'raises an error' do
      expect{subject}.to raise_error(UKMail::ServiceError)
    end
  end

  context 'when the county exists but is not Dublin' do
    let(:county) { 'waterford' }
    let(:postcode) { nil }
    let(:expected_result) { 'D37' }

    it_behaves_like 'correct conversion'
  end

  context 'when the county is Dublin' do
    let(:county) { 'dublin' }

    context 'when the input is invalid' do
      let(:expected_result) { nil }

      context { let(:postcode) { ''          }; it_behaves_like 'invalid input' }
      context { let(:postcode) { 'A14'       }; it_behaves_like 'invalid input' }
      context { let(:postcode) { 'A 5'       }; it_behaves_like 'invalid input' }
      context { let(:postcode) { 'D1A'       }; it_behaves_like 'invalid input' }
      context { let(:postcode) { 'D4 4'      }; it_behaves_like 'invalid input' }
      context { let(:postcode) { 'A'         }; it_behaves_like 'invalid input' }
      context { let(:postcode) { 'D'         }; it_behaves_like 'invalid input' }
      context { let(:postcode) { 'A D9'      }; it_behaves_like 'invalid input' }
      context { let(:postcode) { 'DUBLI4'    }; it_behaves_like 'invalid input' }
      context { let(:postcode) { 'DUBLINA 4' }; it_behaves_like 'invalid input' }
      context { let(:postcode) { 'DUBLIN4A'  }; it_behaves_like 'invalid input' }
    end

    context 'when the input is valid' do
      let(:expected_result) { 'D4' }

      context { let(:postcode) { '4'         }; it_behaves_like 'correct conversion' }
      context { let(:postcode) { '04'        }; it_behaves_like 'correct conversion' }
      context { let(:postcode) { 'D4'        }; it_behaves_like 'correct conversion' }
      context { let(:postcode) { 'D04'       }; it_behaves_like 'correct conversion' }
      context { let(:postcode) { 'D 4'       }; it_behaves_like 'correct conversion' }
      context { let(:postcode) { 'D 04'      }; it_behaves_like 'correct conversion' }
      context { let(:postcode) { 'DUBLIN4'   }; it_behaves_like 'correct conversion' }
      context { let(:postcode) { 'DUBLIN04'  }; it_behaves_like 'correct conversion' }
      context { let(:postcode) { 'DUBLIN 4'  }; it_behaves_like 'correct conversion' }
      context { let(:postcode) { 'DUBLIN 04' }; it_behaves_like 'correct conversion' }
    end
  end
end
