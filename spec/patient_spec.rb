require "spec_helper"

describe 'Patient' do
  describe '#initialize' do

    it 'should save new patient to database' do
      new_patient = Patient.new({name: 'Doug', birthday: '05/21/1981', doctor_id: 1})
      new_patient.save()
      expect(Patient.all()).to(eq([new_patient]))
    end

  end
end
