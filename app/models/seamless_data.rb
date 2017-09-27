class SeamlessData
  attr_accessor :username, :password, :loginUrl, :oldOrdersUrl, :seamless_user_id

  def initialize(seamless_user_number)
    self.username = ENV["SEAMLESS_USER_#{seamless_user_number}"]
    self.password = ENV["SEAMLESS_PASSWORD_#{seamless_user_number}"]
    self.seamless_user_id = ENV["SEAMLESS_USER_ID_#{seamless_user_number}"]
    self.loginUrl = ENV["SEAMLESS_LOGIN_URL"]
    self.oldOrdersUrl = ENV["SEAMLESS_OLD_ORDERS_URL"]
  end
end
