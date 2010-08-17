
Feature: StaticPage public controler

    Scenario Outline: Non admin session can not create a static page
        Given <session> session
        When I go to show static page page
        Then I see the not found page

        Scenarios:
            | session       |
            | an anonymous  |
            | a regular     |

    Scenario: An admin can create a new static page accessing through public show path
        Given an admin session
        When I go to show static page page with from_edit: true
        Then I see show static page
        And page title should be "New page"
        And the page contains a box "action-box"

    Scenario: Show edit to admin
        Given an admin session
        And a static page group with id: 1
        And a static page with name: foo, group_id: 1, content: "Lorem Ipsum"
        When I go to show static page
        Then page title should be "foo"
        And the page contains a box "action-box"

    Scenario Outline: Draft static pages are not shown to non admin users
        Given <session> session
        And a static page group with id: 1
        And a static page with name: foo, group_id: 1, content: "Lorem Ipsum", draft: true
        When I go to show static page
        Then I see not found page

        Scenarios:
            | session       |
            | an anonymous  |
            | a regular     |

    Scenario: Draft warning for static page to admin users 
        Given an admin session
        And a static page group with id: 1
        And a static page with name: foo, group_id: 1, content: "Lorem Ipsum", draft: true
        When I go to show static page
        Then the flash box contains "Warning: This is a draft"
