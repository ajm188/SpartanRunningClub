Given(/^I have no carousel items$/) do
  CarouselItem.delete_all
end

Given(/^I create a new carousel item with the caption "(.*?)"$/) do |caption|
  FactoryGirl.create(:carousel_item, primary_caption: caption)
end

When(/^I go to the home page$/) do
  visit root_path
end

When(/^I am a guest$/) do
  
end

When(/^I am signed in as "(.*?)"$/) do |email|
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
