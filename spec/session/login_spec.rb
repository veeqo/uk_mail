require 'spec_helper'

describe UKMail::Session, '#login' do
  let(:session) { UKMail::Session.new }

  context "before logging in" do
    it "does not have an auth token" do
      expect(session.auth_token).to be_nil
    end
  end

  context "with valid credentials", vcr: { cassette_name: '/session/with_valid_credentials' } do
    let(:username) { ENV['TEST_USERNAME'] }
    let(:password) { ENV['TEST_PASSWORD'] }

    before { session.login(username, password) }

    it "has an auth token" do
      expect(session.auth_token).to_not be_nil
    end
  end

  context "with invalid credentials", vcr: { cassette_name: '/session/with_invalid_credentials' } do
    let(:username) { 'badname' }
    let(:password) { 'badpass' }

    subject { session.login(username, password) }

    it "raises an AuthenticationError" do
      expect{subject}.to raise_error(UKMail::AuthenticationError)
    end
  end
end
