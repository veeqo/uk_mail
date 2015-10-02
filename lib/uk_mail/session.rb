module UKMail
  class Session
    def initialize(_auth_token = nil)
      @auth_token = _auth_token
    end

    def login(username, password)
      login_result = Service::Authentication.new(nil).login(username: username, password: password)
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
