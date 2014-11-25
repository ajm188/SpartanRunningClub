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

    # Carousel
    Scenario: Viewing the carousel
        Given I have no carousel items
        And I create a new carousel item with the caption "Hello!"
        When I go to the home page
        Then I should see "Hello!"

    Scenario: Turning the carousel
        Given I have no carousel items
        And I create a new carousel item with the caption "Hello!"
        And I create a new carousel item with the caption "Goodbye!"
        When I go to the home page
        And I click the "›" link
        Then I should see "Goodbye!"

    # Accordion
    Scenario: No events
        Given I have no events
        And I am signed in as "abc132@case.edu"
        When I go to the home page
        Then I should see "View Profile"

    Scenario: Events
        Given I have an event with the name "My Event"
        And I am signed in as "abc231@case.edu"
        When I go to the home page
        Then I should see "My Event"

    Scenario: Outdated Events
        Given I have no events
        And I have an event with the name "My Event" and an upcoming date
        And I have an event with the name "My Other Event" and a past date
        And I am signed in as "aci142@case.edu"
        When I go to the home page
        Then I should see "My Event"
        And I should not see "My Other Event"
