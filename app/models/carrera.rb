class Carrera < ActiveRecord::Base
  
  self.table_name= "carreras"
  self.primary_key = "id"
  
  attr_accessible :id, :inscripcion_id, :fecha, :estado_carrera_id, :created_at, :updated_at
 
  scope :orden_01, -> { order("id")}
  scope :orden_fecha, -> { order("fecha asc")}

  
end