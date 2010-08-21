
Feature: StaticPage public controler

    @create
    Scenario Outline: Non admin users can not create a static page
        Given <session> session
        When I go to the new static page page
        Then I see the <content>

        Scenarios:
            | session        | content          |
            | an anonymous   | "login form" box |
            | a regular user | forbidden page   |

    @create
    Scenario: Admin users can create new static pages
        Given an admin session
        When I go to the new static page page with from_edit: "true"
        And I fill in the "static page" form with:
            | Name      | foo                           |
            | Content   | This is the foo content       |
        And I submit the "static page" form
        Then I go to the static pages page
        And the page contains these boxes within "static page item":
            | Name      | foo                           |
            | Content   | This is the foo content       |

    Scenario Outline: Non admin users can not see draft static pages
        Given <session> session
        And a static page group exists with name: "Pages Group"
        And a static page exists with name: "Test page", group: "Pages Group", content: "Lorem Ipsum", draft: true
        When I go to the static page with id: "test-page"
        Then I see the <content>

        Scenarios:
            | session        | content          |
            | an anonymous   | "login form" box |
            | a regular user | forbidden page   |

    Scenario: Admin users see a draft warning for static page
        Given an admin session
        And a static page group exists with name: "Pages Group"
        And a static page exists with name: "Test page", group: "Pages Group", content: "Lorem Ipsum", draft: true
        When I go to the static page with id: "test-page"
        Then the flash box contains "Warning: This is a draft"
