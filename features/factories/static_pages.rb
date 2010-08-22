Factory.define :static_page do |page|
  page.name "Static page test"
  page.description "Static page for tests"
  page.locale "es"
  page.content "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
  page.group_id 1
  page.draft false
end
