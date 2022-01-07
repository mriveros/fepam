class Votante < ActiveRecord::Base

  self.table_name="votantes"
  self.primary_key="id"
  
  attr_accessible :id, :seccional_id, :numero_local, :cedula, :apellidos, :nombres, :direccion, :partido, :fecha_nacimiento, :fecha_afiliacion, :departamento_id
  
  scope :orden_01, -> { order("id")}
  
end