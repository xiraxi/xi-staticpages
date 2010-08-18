
Feature: StaticPage Group features

    Scenario Outline: StaticPage Group front static page depends on locale and can be nil
        Given an anonymous session
        And a static page group exists with name: "First"
        And a static page group exists with name: "Second"
        And locale is <locale>
        And a static page exists with: name: "foo", content: "Lorem Ipsum", group: "<group>", locale: "<page-locale>", front: "<front>"
        When I load static page group with id: 1
        Then static page should be <page>

        Scenarios:
            | locale | group  | page-locale | front | page |
            | es     | First  | es          | true  | foo  |
            | en     | First  | en          | true  | foo  |
            | es     | First  | es          | false | nil  |
            | es     | First  | en          | true  | nil  |
            | es     | Second | es          | true  | nil  |
            | es     | Second | en          | true  | nil  |
            | es     | Second | es          | false | nil  |
