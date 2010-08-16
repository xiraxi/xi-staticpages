
Feature: Basic CRUD StaticPage

    Scenario Outline: Only admin users can access StaticPages CRUD
        Given a non admin session
        When I open <action> page
        Then I see not found page

        Scenarios:
            | action                |
            | static pages          |
            | new static page       |
            | edit static page      |
            | destroy static page   |

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
        And a static page group exists with id: 1
        When I go to new static page page
        And I submit the form
        Then these field have errors: name, group_id, content
