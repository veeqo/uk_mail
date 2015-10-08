shared_examples_for "endpoint_url" do
  subject { service.endpoint_url }

  context "when in production mode" do
    before { UKMail.configure { |config| config.env = :production } }

    it { is_expected.to start_with 'https://api.ukmail.com' }
  end

  context "when in test mode" do
    before do
      UKMail.configure { |config| config.env = :test }
    end

    it { is_expected.to start_with 'https://qa-api.ukmail.com' }
  end

  context "when in an unrecognised mode" do
    before do
      UKMail.configure { |config| config.env = :potato }
    end

    it { is_expected.to start_with 'https://qa-api.ukmail.com' }
  end
end
