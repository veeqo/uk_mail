require 'spec_helper'

describe UKMail::PostcodeData, '#ireland_postcode' do
  let(:ireland_data) { UKMail::IrelandData.new(county, postcode) }

  subject { ireland_data.ireland_postcode }

  shared_examples_for 'expected result' do
    it { is_expected.to eq(expected_result) }
  end

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

    it { is_expected.to eq('D37') }
  end

  context 'when the county is Dublin' do
    let(:county) { 'dublin' }

    context 'when the input is invalid' do
      let(:expected_result) { nil }

      context { let(:postcode) { ''          }; it_behaves_like 'expected result' }
      context { let(:postcode) { 'A14'       }; it_behaves_like 'expected result' }
      context { let(:postcode) { 'A 5'       }; it_behaves_like 'expected result' }
      context { let(:postcode) { 'D1A'       }; it_behaves_like 'expected result' }
      context { let(:postcode) { 'D4 4'      }; it_behaves_like 'expected result' }
      context { let(:postcode) { 'A'         }; it_behaves_like 'expected result' }
      context { let(:postcode) { 'D'         }; it_behaves_like 'expected result' }
      context { let(:postcode) { 'A D9'      }; it_behaves_like 'expected result' }
      context { let(:postcode) { 'DUBLI4'    }; it_behaves_like 'expected result' }
      context { let(:postcode) { 'DUBLINA 4' }; it_behaves_like 'expected result' }
      context { let(:postcode) { 'DUBLIN4A'  }; it_behaves_like 'expected result' }
    end

    context 'when the input is valid' do
      let(:expected_result) { 'D4' }

      context { let(:postcode) { '4'         }; it_behaves_like 'expected result' }
      context { let(:postcode) { '04'        }; it_behaves_like 'expected result' }
      context { let(:postcode) { 'D4'        }; it_behaves_like 'expected result' }
      context { let(:postcode) { 'D04'       }; it_behaves_like 'expected result' }
      context { let(:postcode) { 'D 4'       }; it_behaves_like 'expected result' }
      context { let(:postcode) { 'D 04'      }; it_behaves_like 'expected result' }
      context { let(:postcode) { 'DUBLIN4'   }; it_behaves_like 'expected result' }
      context { let(:postcode) { 'DUBLIN04'  }; it_behaves_like 'expected result' }
      context { let(:postcode) { 'DUBLIN 4'  }; it_behaves_like 'expected result' }
      context { let(:postcode) { 'DUBLIN 04' }; it_behaves_like 'expected result' }
    end
  end
end
