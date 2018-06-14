require 'rest-client'

def sign_up_positive
  payload = {
      'email' => 'reinis@email.com',
      'firstName' => 'Reinis',
      'lastName' => 'Yes',
      'password' => 'parole123'
  }.to_json

  # response = RestClient::Request.execute(method: :post,
  #                                        url: 'http://195.13.194.180:8090/api/sign-up' ,
  #                                        headers: {'Content-Type' => 'application/json'},
  #                                        cookies: {},
  #                                        payload: payload)

  response = API.post('http://195.13.194.180:8090/api/sign-up',
                      headers: {'Content-Type' => 'application/json'},
                      cookies: {},
                      payload: payload)

  # Check if 200 OK is received
  # assert_equal(200, response.code, "Failed to create a new account. Response: #{}")
  assert_status_code(200, response, "Sign up")
end