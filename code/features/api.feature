Feature: Main API
  As an API client
  I want to be able to query helloworld and secret

  Background: Set server name
    Given I am using server "$SERVER"

  Scenario: Ensure root endpoint exists
    When I make a GET request to "/"
    Then the response status should be 200
    And the response content should be "Hello, World!"

  Scenario: Ensure bounty endpoint exists
    When I make a GET request to "/secret"
    Then the response status should be 200
    And the response content should be "You won the bounty!"

  Scenario: Ensure post is not supported
    When I make a POST request to "/secret"
    Then the response status should be 405

  Scenario: Ensure no existing urls raise 404
    When I make a GET request to "/whereami"
    Then the response status should be 404
