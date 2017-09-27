class SeamlessData
  attr_accessor :username, :password, :loginUrl, :oldOrdersUrl

  def initialize
    user_number = [1,2,3].sample

    self.username = ENV["SEAMLESS_USER_#{user_number}"]
    self.password = ENV["SEAMLESS_PASSWORD_#{user_number}"]
    self.loginUrl = ENV["SEAMLESS_LOGIN_URL"]
    self.oldOrdersUrl = ENV["SEAMLESS_OLD_ORDERS_URL"]
  end
end
