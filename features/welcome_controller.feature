Feature: The Home Page
    As a user
    I want to be able to see the home page

    Scenario: Welcome Text
        When I go to the home page
        Then I should see "Welcome to Spartan Running Club!"

    Scenario: Guest user
        When I am a guest
        And I go to the home page
        Then I should see "Sign In"
        And I should see "Sign Up"

    Scenario: Member
        When I am signed in as "abc123@case.edu"
        And I go to the home page
        Then I should see "Upcoming Events"
        And I should see "Quick Links"
