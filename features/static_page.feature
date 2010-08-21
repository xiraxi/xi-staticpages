
Feature: Basic CRUD StaticPage

    Scenario Outline: Only admin users can access StaticPages CRUD
        Given <session> session
        When I go to the <action> page
        Then I see not found page

        Scenarios:
            | session       | action                |
            | a regular     | static pages          |
            | a regular     | new static page       |
            | a regular     | edit static page      |
            | a regular     | destroy static page   |
            | an anonymous  | static pages          |
            | an anonymous  | new static page       |
            | an anonymous  | edit static page      |
            | an anonymous  | destroy static page   |

    Scenario: Index shows certain fields
        Given an admin session
        When I go to the static pages page
        Then the page contains these boxes within "crud-index":
            | Position      |
            | Draft         |
            | Name          |
            | Locale        |
            | Front         |
            | Special type  |
            | Group_id      |

    Scenario: Admin can create a StaticPage
        Given an admin session
        And a static page group exists with id: 1
        When I go to the new static page page
        And I fill in the "basic-crud" form with:
            | Position      | 1                 |
            | Draft         | false             |
            | Name          | Foo               |
            | Locale        | es                |
            | Front         | true              |
            | Special type  | nil               |
            | Group_id      | 1                 |
            | Tags          | foo, bar          |
            | Description   | Short description |
            | Content       | Lorem Ipsum       |
        And I submit the form
        Then I see the static pages page
        And the flash box contains "Successfully created"
        And the page contains these boxes within "crud-index"
            | Position      | 1                 |
            | Draft         | false             |
            | Name          | Foo               |
            | Locale        | es                |
            | Front         | true              |
            | Special type  | nil               |
            | Group_id      | 1                 |
            | Tags          | foo, bar          |
            | Description   | Short description |
            | Content       | Lorem Ipsum       |

    Scenario: StaticPage can not be empty
        Given an admin session
        When I go to the new static page page
        And I submit the form
        Then these field have errors: name, group_id, content

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
