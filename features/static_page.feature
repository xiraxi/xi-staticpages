
Feature: Basic CRUD StaticPage

    Scenario Outline: Only admin users can access StaticPages CRUD
        Given <session> session
        When I open <action> page
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
        When I go to static pages page
        Then the page contains these boxes within "crud-index":
            | position      |
            | draft         |
            | name          |
            | locale        |
            | front         |
            | special type  |
            | group_id      |

    Scenario: Admin can create a StaticPage
        Given an admin session
        And a static page group exists with id: 1
        When I go to new static page page
        And I fill the "basic-crud" form with:
            | position      | 1                 |
            | draft         | false             |
            | name          | Foo               |
            | locale        | es                |
            | front         | true              |
            | special type  | nil               |
            | group_id      | 1                 |
            | tags          | foo, bar          |
            | description   | Short description |
            | content       | Lorem Ipsum       |
        And I submit the form
        Then I see the static pages page
        And the flash box contains "Successfully created"
        And the page contains these boxes within "crud-index"
            | position      | 1                 |
            | draft         | false             |
            | name          | Foo               |
            | locale        | es                |
            | front         | true              |
            | special type  | nil               |
            | group_id      | 1                 |
            | tags          | foo, bar          |
            | description   | Short description |
            | content       | Lorem Ipsum       |

    Scenario: StaticPage can not bem empty
        Given an admin session
        When I go to new static page page
        And I submit the form
        Then these field have errors: name, group_id, content

    Scenario Outline: StaticPage can be found through finder
        Given an anonymous session
        And a static page group exists with id: 1
        And a static page with name: "foo", group_id: 1, content: "Lorem Ipsum"
        When I go to front page
        And I fill the "search" form with:
            | q | <search>  |
        And I submit the form
        Then I see the search result page
        And the page contain these boxes within "finder" table:
            | items-label   | Pages |
            | items-content | foo   |

            Scenarios:
                | q     |
                | foo   |
                | Lorem |
                | Ipsum |
