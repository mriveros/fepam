class VVotante < ActiveRecord::Base

  self.table_name="v_votantes"
  self.primary_key="votante_id"
  
  attr_accessible :id, :seccional_id, :seccional, :numero_local, :cedula, :apellidos, :nombres, :direccion, :partido, :fecha_nacimiento, :fecha_afiliacion, :departamento_id, :departamento
  
  
  scope :orden_01, -> { order("votante_id")}
  scope :orden_descripcion, -> { order("nombre_razon_social")}
  
end