Feature: Post feature
  Tests the functionality of post

  Scenario: Create a post - positive
    Given I have logged in as a regular user
    When I create a new post
    Then I check if the post is posted
    And I update posts title