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

describe 'patient_new route', {type: :feature} do
  it 'should allow user to add a patient to a doctor' do
    new_doctor = Doctor.new({name: 'Doug', specialty: 'Orthopedics'})
    new_doctor.save()
    visit('/')
    click_link('Doug')
    click_link('Add a Patient')
    fill_in('name', with: 'Angela')
    fill_in('birthday', with: '03/10/2010')
    click_button('Add a Patient')
    # save_and_open_page
    expect(page).to have_content("Angela")
  end
end

describe 'add_doctor route', {type: :feature} do
  it 'should allow user to change a patients docotor id' do
    new_doctor = Doctor.new({name: 'Doug', specialty: 'Orthopedics'})
    new_doctor2 = Doctor.new({name: 'Arlong', specialty: 'Orthopedics'})
    new_doctor.save()
    new_doctor2.save()
    new_patient = Patient.new({name: "Umbria", birthday: "12/12/12", doctor_id: new_doctor.id()})
    new_patient.save()
    visit('/')
    click_link('Doug')
    click_link('Change Doctor')
    fill_in('doctor_id', with: new_doctor2.id())
    click_button('Assign Doctor')
    # save_and_open_page
    expect(page).to have_content("Umbria")
  end
end
