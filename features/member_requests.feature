Feature: Member Requests
    In order to manage member requests
    As an officer
    I want to be able to view, approve and deny member requests

    Scenario: Notifications
        Given There are no pending requests
        And A request has been made
        And I am an officer
        When I go to the home page
        Then I should have one notification near my name

    Scenario: Admin Panel with a Pending Request
        Given There are no pending requests
        And A request has been made
        And I am an officer
        When I go to the admin panel
        Then I should see "Approve Requests"
        And I should see "1 request needs your attention!"

    Scenario: Admin Panel with no pending requests
        Given There are no pending requests
        And I am an officer
        When I go to the admin panel
        Then I should not see "Approve Requests"

    @javascript
    Scenario: Approve a request
        Given There are no pending requests
        And A request has been made
        And I am an officer
        When I go to the requests page
        And I click the tooltip "Approve"
        Then I should see "Request approved."
        And There should be 0 requests

    @javascript
    Scenario: Deny a request
        Given There are no pending requests
        And A request has been made
        And I am an officer
        When I go to the requests page
        And I click the tooltip "Deny (and delete)"
        And I accept the dialog
        Then I should see "Request denied."
        And There should be 0 requests

    @javascript
    Scenario: Deny, but cancel
        Given There are no pending requests
        And A request has been made
        And I am an officer
        When I go to the requests page
        And I click the tooltip "Deny (and delete)"
        And I dismiss the dialog
        Then There should be 1 request
