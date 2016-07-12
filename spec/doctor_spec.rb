require 'rspec'
require 'pg'
require 'doctor'
require 'pry'

DB = PG.connect({:dbname => 'doctors_office_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM doctors *")
  end
end

describe 'Doctor' do
  describe '#initialize' do
    it 'should save new doctor to database' do
      new_doctor = Doctor.new({name: 'Doug', specialty: 'Orthopedics'})
      new_doctor.save()
      expect(Doctor.all()).to(eq([new_doctor]))
    end
  end
  describe '#find' do
    it 'should find doctor form database with id' do
      new_doctor = Doctor.new({name: 'Doug', specialty: 'Orthopedics'})
      new_doctor.save()
      expect(Doctor.find(new_doctor.id())).to(eq(new_doctor))
    end
  end

end
