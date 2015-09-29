require 'uk_mail/service/authentication'

module UKMail
  class Session
    def login(username, password)
      login_result = Service::AuthenticationService.new(nil).login(username: username, password: password)
      @auth_token = login_result.authenticationToken
      login_result
    end

    def authenticated?
      !@auth_token.nil?
    end

    def auth_token
      @auth_token
    end
  end
end
