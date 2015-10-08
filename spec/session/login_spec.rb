require 'spec_helper'

describe UKMail::Session, '#login' do
  let(:session) { UKMail::Session.new }

  context "before logging in" do
    it "does not have an auth token" do
      expect(session.auth_token).to be_nil
    end
  end

  context "after logging in" do
    let(:username) { 'testname' }
    let(:password) { 'testpass' }

    before { session.login(username, password) }

    it "has an auth token" do
      expect(session.auth_token).to be_present
    end
  end
end
