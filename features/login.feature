Feature: Login feature
  Tests the functionality of login

  Scenario: Log in - positive
    Given I have logged in as a regular user
    Then I can access my profile information

  Scenario: Log in - negative
    Given I try to log in using an invalid password
    Then I check if I am not logged in