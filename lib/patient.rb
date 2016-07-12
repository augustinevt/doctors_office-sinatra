class Patient
  attr_reader(:name, :doctor_id, :birthday, :id)

  def initialize(attributes)
    @name = attributes[:name]
    @doctor_id = attributes[:doctor_id]
    @birthday = attributes[:birthday]
    @id = attributes[:id]
  end

  def self.all
    returned_patients = DB.exec("SELECT * FROM patients")
    patients =[]
    returned_patients.each() do |patient|
      patients.push(Patient.new({name: patient['name'], birthday: patient['birthday'], doctor_id: patient['doctor_id'].to_i, id: patient['id'].to_i}))
    end
    patients
  end

  def save
    result = DB.exec("INSERT INTO patients (name, birthday, doctor_id) VALUES ('#{@name}', '#{@birthday}', '#{@doctor_id}') RETURNING id;").first()
    @id = result['id'].to_i()

  end

  def ==(other_patient)
    self.name() == other_patient.name() && self.id() == other_patient.id()
  end

  def add_doctor(doctor_id)
    DB.exec("DELETE FROM patients WHERE id = #{@id}").first()
    @doctor_id = doctor_id
  end

  def self.patient_list(doctor_id)
    returned_patients = DB.exec("SELECT * FROM patients WHERE doctor_id = '#{doctor_id}';")
    patients = []
    returned_patients.each do |patient|
        patients.push(Patient.new({name: patient['name'], birthday: patient['birthday'], doctor_id: patient['doctor_id'].to_i, id: patient['id'].to_i}))
    end
    patients
  end

  def self.find(id)
    result = DB.exec("SELECT * FROM patients WHERE id = #{id}").first()
    patient = Patient.new({name: result['name'], birthday: result['birthday'], doctor_id: result['doctor_id'].to_i, id: result['id'].to_i})
  end

end
