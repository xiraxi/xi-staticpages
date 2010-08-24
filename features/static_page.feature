
Feature: Basic CRUD StaticPage

    Scenario Outline: Only admin users can access StaticPages CRUD
        Given <session> session
        When I go to the <action>
        Then I see the <page> page
        Scenarios:
          | session        | action                             | page      |
          | a regular user | static pages page                  | forbidden |
          | a regular user | new static page page               | forbidden |
          | a regular user | edit static page page with id: "1" | forbidden |
          | an anonymous   | static pages page                  | login     |
          | an anonymous   | new static page page               | login     |
          | an anonymous   | edit static page page with id: "1" | login     |

    Scenario: StaticPage can not be empty
        Given an admin session
        When I go to the new static page page
        And I submit the form
        Then these fields have errors: Title, Content

    Scenario: Index shows certain fields
        Given an admin session
        And a static page exists with id: 1
        When I go to the static pages page
        Then the "static page" box has these boxes in the same order:
            | Title        |
            | Locale       |

    Scenario: Admin can create a StaticPage
        Given an admin session
        When I go to the new static page page
        And I fill in the following:
            | Title        | Foo               |
            | Content      | Lorem Ipsum       |
        And I select "English" from "Locale"
        And I submit the form
        Then the flash box contains "The static page has been created successfuly"
        And a static page exists with title: "Foo", content: "Lorem Ipsum", locale: en

    Scenario Outline: StaticPage can be found through finder
        Given an anonymous session
        And a static page group exists with id: 1
        And a static page exists with name: "foo", group_id: 1, content: "Lorem Ipsum"
        When I go to the front page
        And I fill in the "search" form with:
            | q | <search>  |
        And I submit the form
        Then I see the search result page
        And the page contains these boxes within "finder" table:
            | items-label   | Pages |
            | items-content | foo   |

            Scenarios:
                | search   |
                | foo      |
                | Lorem    |
                | Ipsum    |
