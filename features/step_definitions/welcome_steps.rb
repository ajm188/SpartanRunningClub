Given(/^I have no (.*?)$/) do |model|
  model.split(' ').join('_').singularize.camelcase.constantize.delete_all
end

Given(/^I create a new carousel item with the caption "(.*?)"$/) do |caption|
  FactoryGirl.create(:carousel_item, primary_caption: caption)
end

Given(/^I have an event with the name "(.*?)"$/) do |name|
  unless Event.exists?(name: name)
    FactoryGirl.create(:event, name: name)
  end
end

When(/^I go to the home page$/) do
  visit root_path
end

When(/^I am a guest$/) do
end

When(/^I am signed in as "(.*?)"$/) do |email|
  if Member.exists?(email: email)
    Member.delete_all(email: email)
  end
  @member = FactoryGirl.create(:member, email: email, password: 'password')
  visit('/sign_in')
  fill_in('session_email', with: @member.email)
  fill_in('session_password', with: 'password')
  click_button('Sign In')
end

When(/^I click the "(.*?)" link$/) do |locator|
  click_link locator
end

Then(/^I should see "(.*?)"$/) do |content|
  expect(page).to have_content(content)
end
