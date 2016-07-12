require 'sinatra'
require 'sinatra/reloader'
require 'pg'
require './lib/doctor'
require './lib/patient'
require 'pry'
also_reload 'lib/**/*.rb'

DB = PG.connect({dbname: 'doctors_office'})

get ('/') do
  @doctors = Doctor.all()
  erb(:index)
end

get ('/doctor_new') do
  erb(:doctor_new)
end

post ('/doctor/create') do
  new_doctor = Doctor.new({name: params[:name], specialty: params[:specialty]})
  new_doctor.save()
  redirect '/'
end

get ('/doctor/:id') do

  @doctor = Doctor.find(params[:id])
  @id = @doctor.id()
  @patients = Patient.patient_list(@doctor.id())
  erb(:doctor)
end

get ('/patient_new') do
  @doctor_id = params[:doctor_id]
  erb(:patient_new)
end

post ('/patient/create') do
  new_patient = Patient.new({name: params[:name], birthday: params[:birthday], doctor_id: params[:doctor_id]})
  new_patient.save()
  redirect "/doctor/#{params[:doctor_id]}"
end

get('/change_doctor') do
  @patient = Patient.find(params[:patient_id])
  @doctors = Doctor.all()
  erb(:add_doctor)
end

post('/change_doctor') do
  patient = Patient.find(params[:patient_id].to_i)
  patient.add_doctor(params[:doctor_id].to_i)
  patient.save()
  redirect "/doctor/#{params[:doctor_id]}"
end
