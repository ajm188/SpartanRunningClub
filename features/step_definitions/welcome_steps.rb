When(/^I go to the home page$/) do
  visit root_path
end

Then(/^I should see "(.*?)"$/) do |content|
  expect(page).to have_content(content)
end
