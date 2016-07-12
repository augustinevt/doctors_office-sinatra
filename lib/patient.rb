class Patient
  attr_reader(:name, :doctor_id, :birthday)

  def initialize(attributes)
    @name = attributes[:name]
    @doctor_id = attributes[:doctor_id]
    @birthday = attributes[:birthday]
  end

  def self.all
    returned_patients = DB.exec("SELECT * FROM patients")
    patients =[]
    returned_patients.each() do |patient|
      patients.push(Patient.new({name: patient['name'], birthday: patient['birthday'], doctor_id: patient['doctor_id'].to_i}))
    end
    patients
  end

  def save
    result = DB.exec("INSERT INTO patients (name, birthday, doctor_id) VALUES ('#{@name}', '#{@birthday}', '#{@doctor_id}');")
  end

  def ==(other_patient)
    self.name() == other_patient.name() && self.doctor_id() == other_patient.doctor_id()
  end

  def add_doctor(doctor_id)
    @doctor_id = doctor_id
  end

  def self.patient_list(doctor_id)
    returned_patients = DB.exec("SELECT * FROM patients WHERE doctor_id = '#{doctor_id}';")
    patients = []
    returned_patients.each do |patient|
        patients.push(Patient.new({name: patient['name'], birthday: patient['birthday'], doctor_id: patient['doctor_id'].to_i}))
    end
    patients
  end

end
