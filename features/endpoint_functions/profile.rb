require 'rest-client'

def check_profile_info(user)
  # response = RestClient::Request.execute(method: :get,
  #                                        url: 'http://195.13.194.180:8090/api/profile' ,
  #                                        headers: {'Authorization' => user.auth_token},
  #                                        cookies: {})

  response = API.get('http://195.13.194.180:8090/api/profile',
                      headers: {'Authorization' => user.auth_token},
                      cookies: {})

  # Check if 200 OK is received
  # assert_equal(200, response.code, "Failed to Check profile info. Response: #{response}")
  assert_status_code(200, response, "Profile check")

  response_hash = JSON.parse(response)

  # Check if id is correct
  assert_equal(user.id, response_hash['id'], 'Ids dont match')

  # Check email is correct
  assert_equal(user.email, response_hash['email'], 'Email is not correct')

  # Check first name is correct
  assert_equal(user.firstName, response_hash['firstName'], 'First name is not correct')
end