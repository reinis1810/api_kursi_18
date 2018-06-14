require 'rest-client'

def login_positive(user)
  payload = {
      'email' => user.email,
      'password' => user.password
  }.to_json

  # response = RestClient::Request.execute(method: :post,
  #                                        url: 'http://195.13.194.180:8090/api/login' ,
  #                                        headers: {'Content-Type' => 'application/json'},
  #                                        cookies: {},
  #                                        payload: payload)

  response = API.post('http://195.13.194.180:8090/api/login',
                      headers: {'Content-Type' => 'application/json'},
                      cookies: {},
                      payload: payload)

  # Check if 200 OK is received
  # assert_equal(200, response.code, "Failed to log in. Response: #{response}") #old pirms assert_helper.rb
  assert_status_code(200, response, "Login")

  response_hash = JSON.parse(response)

  # Check if correct user is returned
  assert_equal(user.email, response_hash['email'], 'Logged in user is not correct')

  user.firstName = response_hash['firstName']
  user.lastName = response_hash['lastName']
  user.id = response_hash['id']
  user.auth_token = response.headers[:authorization]
end

def login_wrong_password(user)
  payload = {
      'email' => user.email,
      'password' => user.password
  }.to_json

  response = API.post('http://195.13.194.180:8090/api/login',
                      headers: {'Content-Type' => 'application/json'},
                      cookies: {},
                      payload: payload)

  # response = RestClient::Request.execute(method: :post,
  #                                        url: 'http://195.13.194.180:8090/api/login' ,
  #                                        headers: {'Content-Type' => 'application/json'},
  #                                        cookies: {},
  #                                        payload: payload)

  # Check if 401 is received
  # assert_equal(401, response.code, "Response code is not correct. Response: #{response}")
  assert_status_code(401, response, "Login wrong password")
  p response

  response_hash = JSON.parse(response)

  # Check if correct user is returned
  assert_equal("Login failed!", response_hash['status'], 'Wrong error message returned')
  user.auth_token = response.headers[:authorization]

end

def check_if_user_not_logged(user)
  response = API.get('http://195.13.194.180:8090/api/profile',
                     headers: {'Authorization' => user.auth_token},
                     cookies: {})

  # assert_equal(403, response.code, "User is able to fetch profile data. Response: #{response}")
  assert_status_code(403, response, "Profile check empty auth")
end