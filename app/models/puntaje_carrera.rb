class PuntajeCarrera < ActiveRecord::Base
  
  self.table_name= "puntajes_carreras"
  self.primary_key = "id"
  
  attr_accessible :id, :carrera_id, :fecha, :created_at, :updated_at
 
  scope :orden_01, -> { order("id")}
  scope :orden_carrera, -> { order("carrera_id desc")}

  
end