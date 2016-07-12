require "spec_helper"

describe 'Patient' do
  describe '#initialize' do
    it 'should save new patient to database' do
      new_patient = Patient.new({name: 'Doug', birthday: '05/21/1981', doctor_id: 1})
      new_patient.save()
      expect(Patient.all()).to(eq([new_patient]))
    end
  end

  describe '#add_doctor' do
    it 'should assign parameter value to @doctor_id' do
      new_patient = Patient.new({name: 'Doug', birthday: '05/21/1981', doctor_id: 0})
      new_patient.save()
      new_patient.add_doctor(1)
      expect(new_patient.doctor_id).to(eq(1))
    end
  end

  describe '#patient_list' do
    it 'should return a list of patients assigned to a doctor' do
      new_patient = Patient.new({name: 'Doug', birthday: '05/21/1981', doctor_id: 1})
      new_patient.save()
      new_patient2 = Patient.new({name: 'Frank', birthday: '06/01/1989', doctor_id: 1})
      new_patient2.save()
      expect(Patient.patient_list(1)).to eq([new_patient,new_patient2])
    end
  end

  describe '#find' do
    it 'should find patient form database with id' do
      new_patient = Patient.new({name: 'Doug', birthday: '05/21/1981', doctor_id: 1})
      new_patient.save()
      expect(Patient.find(new_patient.id)).to(eq(new_patient))
    end
  end
end
