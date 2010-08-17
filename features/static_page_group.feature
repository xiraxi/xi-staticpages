
Feature: StaticPage Group features

    Scenario Outline: StaticPage Group front static page depends on locale and can be nil
        Given an anonymous session
        And a static page group with id: 1
        And a static page group with id: 2
        And locale is <locale>
        And a static page with:
            | name      | foo           |
            | content   | Lorem Ipsum   |
            | group_id  | <group>       |
            | locale    | <page_locale> |
            | front     | <front>       |
        When I load static page group with id: 1
        Then static page should be <page>

        Scenarios:
            | locale    | group | page_locale   | front | page  |
            | es        | 1     | es            | true  | foo   |
            | en        | 1     | en            | true  | foo   |
            | es        | 1     | es            | false | nil   |
            | es        | 1     | en            | true  | nil   |
            | es        | 2     | es            | true  | nil   |
            | es        | 2     | en            | true  | nil   |
            | es        | 2     | es            | false | nil   |
