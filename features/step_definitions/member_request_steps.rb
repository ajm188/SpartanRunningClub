Given(/^There are no pending requests$/) do
  Member.delete_all(request: true)
end

Given(/^A request has been made$/) do
  FactoryGirl.create(:member, request: true)  
end

Given(/^I am an officer$/) do
  Member.delete_all(officer: true)
  @officer = FactoryGirl.create(:member, :officer, password: 'password')
  visit('/sign_in')
  fill_in('session_email', with: @officer.email)
  fill_in('session_password', with: 'password')
  click_button('Sign In')
end

When(/^I go to the admin panel$/) do
  visit admin_panel_path
end

When(/^I go to the requests page$/) do
  visit requests_members_path
end

When(/^I click the tooltip "(.*?)"$/) do |original_title|
  find("a[data-original-title='#{original_title}']").click
end

When(/^I (.*?) the dialog$/) do |action|
  page.driver.browser.switch_to.alert.send(action.to_sym)
end

Then(/^I should have one notification near my name$/) do
  expect(page).to have_selector('span.badge', text: '1')
end

Then(/^I should not see "(.*?)"$/) do |content|
  expect(page).to_not have_content(content)
end

Then(/^There should be (\d+) requests?$/) do |count|
  expect(Member.where(request: true).count).to eq count.to_i
end
