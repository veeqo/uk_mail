module UKMail
  class Session
    attr_accessor :auth_token

    def initialize(_auth_token = nil)
      @auth_token = _auth_token
    end

    def login(username, password)
      login_result = Service::Authentication.new(nil).login(username: username, password: password)
      @auth_token = login_result.authenticationToken
      if login_result.result != 'Successful'
        raise AuthenticationError, login_result.errors.map{ |e| format_error(e) }.join("\n")
      end
      login_result
    end

    def authenticated?
      !@auth_token.nil?
    end

    def format_error error
      "#{error.code}: #{error.description}"
    end
  end
end
