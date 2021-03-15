require 'spec_helper'

describe UKMail::Configuration, '#postcode_data_path' do
  subject { UKMail.config.postcode_data_path }

  context 'when the configured value is a string' do
    before do
      UKMail.configure do |config|
        config.postcode_data_path = 'abcde.dat'
      end
    end

    it 'returns the configured value' do
      expect(subject).to eq('abcde.dat')
    end
  end

  context 'when the configured value is a proc' do
    before do
      UKMail.configure do |config|
        config.postcode_data_path = -> {
          'fghij.dat'
        }
      end
    end

    it 'returns the configured value' do
      expect(subject).to eq('fghij.dat')
    end
  end
end
