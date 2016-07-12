class Doctor
  attr_reader(:name, :id, :specialty)

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
    @specialty = attributes[:specialty]
  end

  def self.all
    returned_doctors = DB.exec("SELECT * FROM doctors")
    doctors =[]
    returned_doctors.each() do |doctor|
      doctors.push(Doctor.new({name: doctor['name'], specialty: doctor['specialty'], id: doctor['id'].to_i}))
    end
    doctors
  end

  def save
    result = DB.exec("INSERT INTO doctors (name, specialty) VALUES ('#{@name}', '#{@specialty}') RETURNING id;")
    @id = result.first['id'].to_i
  end

  def self.find(id)
    result = DB.exec("SELECT * FROM doctors WHERE id = #{id}").first()
    doctor = Doctor.new({name: result['name'], specialty: result['specialty'], id: result['id'].to_i})
  end

  def ==(other_doctor)
    self.name() == other_doctor.name() && self.id() == other_doctor.id()
  end

end
