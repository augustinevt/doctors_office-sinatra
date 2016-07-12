require 'spec_helper'

describe 'index route', {type: :feature} do
  it 'should list all doctors' do
    new_doctor = Doctor.new({name: 'Doug', specialty: 'Orthopedics'})
    new_doctor.save()
    visit('/')
    expect(page).to have_content("Doug")
  end
end

describe 'doctor_new route', {type: :feature} do
  it 'should allow user to add a doctor' do
    new_doctor = Doctor.new({name: 'Doug', specialty: 'Orthopedics'})
    new_doctor.save()
    visit('/')
    click_link('Add Doctor')
    fill_in('name', with: 'Angura')
    fill_in('specialty', with: 'Acupuncture')
    click_button('Add Doctor')
    expect(page).to have_content("Angur")
  end
end

describe 'doctor/:id route', {type: :feature} do
  it 'doctor page should display patients' do
    new_doctor = Doctor.new({name: 'Doug', specialty: 'Orthopedics'})
    new_doctor.save()
    new_patient = Patient.new({name: "Alice", birthday: "12/12/12", doctor_id: new_doctor.id()})
    new_patient.save()
    visit('/')
    click_link('Doug')
    expect(page).to have_content("Alice")
  end
end
