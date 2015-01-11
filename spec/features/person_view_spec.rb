require 'rails_helper'

describe 'the person view', type: :feature do

  let(:person) { Person.create(first_name: 'John', last_name: 'Doe') }

  describe 'phone numbers' do
    before(:each) do
      person.phone_numbers.create(number: "555-1234")
      person.phone_numbers.create(number: "555-5678")
      visit person_path(person)   #there is a to_param method that gets called here which returns an object's id by default
    end

    it 'shows the phone numbers' do
      person.phone_numbers.each do |phone|
        expect(page).to have_content(phone.number)
      end
    end

    it 'has a link to add a new phone number' do
      expect(page).to have_link('Add phone number', href: new_phone_number_path(person_id: person.id))   #this test is odd. what are we passing into path?
    end

    it 'adds a new phone number' do
      page.click_link('Add phone number')
      page.fill_in('Number', with: '555-8888')    #page is different now
      page.click_button('Create Phone number')
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('555-8888')
    end

    it 'deletes an existing phone number' do
      first(:link, 'delete').click
      expect(current_path).to eq(person_path(person))
      expect(page).to_not have_content('555-1234')
    end

    it 'has links to edit phone numbers' do
      person.phone_numbers.each do |phone|
        expect(page).to have_link('edit', href: edit_phone_number_path(phone))
      end
    end

    it "has links to delete phone numbers" do
      person.phone_numbers.each do |phone|
        expect(page).to have_link('delete', href: phone_number_path(phone))
      end
    end

    it 'edits a phone number' do
      phone = person.phone_numbers.first
      old_number = phone.number

      first(:link, 'edit').click
      page.fill_in('Number', with: '555-9191')
      page.click_button('Update Phone number')
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('555-9191')
      expect(page).to_not have_content(old_number)
    end
  end

  describe "email addresses" do
    before(:each) do
      person.email_addresses.create(address: "Jwan622@gmail.com")
      person.email_addresses.create(address: "Jwan622@yahoo.com")
      visit person_path(person)
    end

    it 'shows the email addresses' do
      person.email_addresses.each do |email|
        expect(page).to have_selector('li', text: 'Jwan622@gmail.com')
      end
    end

    it "has an add email address link" do
      expect(page).to have_link('Add email address', href: new_email_address_path(person_id: person.id))
    end

    it "adds a new email address" do
      page.click_link('Add email address')
      page.fill_in('Address', with: "Jwan622@gmail.com")
      page.click_button('Create Email address')
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content(person.email_addresses.last.address)
    end

    it "has an edit email address link" do
      person.email_addresses.each do |email|
        expect(page).to have_link('edit', href: edit_email_address_path(email))
      end
    end

    it "links to update an email address work" do    #I would like to go over this test still
      email = person.email_addresses.first
      old_address = email.address

      first(:link, 'edit').click
      page.fill_in('Address', with: 'Jwan622@hotmail.com')
      page.click_button('Update Email address')  #because the f.submit buttin refers to an email_address with a person_id of 1, it will go to update method in controller
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('Jwan622@hotmail.com')
      expect(page).to_not have_content(old_address)
    end

    it "has links to delete an email address" do
      person.email_addresses.each do |email|
        expect(page).to have_link("delete", href: email_address_path(email))
      end
    end

    it "links to delete email addresses work" do
      email = person.email_addresses.first
      old_address = email.address

      first(:link, 'delete').click
      expect(current_path).to eq(person_path(person))
      expect(page).to_not have_content(old_address)
      expect(page).to have_content("Email address was successfully destroyed.")
    end

  end
end
