
Feature: StaticPage public controler

    @create
    Scenario Outline: non admin users can not create a static page
        Given <session> session
        When I go to the new static page page
        Then I see the <content>

        Scenarios:
            | session        | content          |
            | an anonymous   | "login form" box |
            | a regular user | forbidden page   |

    @create
    Scenario: admin users can create new static pages
        Given an admin session
        When I go to the new static page page with from_edit: "true"
        And I fill the "static page" form with:
            | name      | foo                           |
            | content   | This is the foo content       |
        And I submit the "static page" form
        Then I go to the static pages page
        And the page contains these boxes within "static page item":
            | name      | foo                           |
            | content   | This is the foo content       |

    Scenario Outline: Draft static pages are not shown to non admin users
        Given <session> session
        And a static page group exists with name: "Pages Group"
        And a static page exists with name: "Test page", group: "Pages Group", content: "Lorem Ipsum", draft: true
        When I go to the static page with id: "test-page"
        Then I see the <content>

        Scenarios:
            | session        | content          |
            | an anonymous   | "login form" box |
            | a regular user | forbidden page   |

    Scenario: Draft warning for static page to admin users
        Given an admin session
        And a static page group exists with name: "Pages Group"
        And a static page exists with name: "Test page", group: "Pages Group", content: "Lorem Ipsum", draft: true
        When I go to the static page with id: "test-page"
        Then the flash box contains "Warning: This is a draft"
