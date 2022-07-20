class ResumenPuntajeCarrera < ActiveRecord::Base
  
  self.table_name= "resumen_puntajes_carreras"
  self.primary_key = "id"
  
  attr_accessible :id, :carrera_id, :piloto_id, :posicion, :puntaje, :created_at, :updated_at
 
  scope :orden_01, -> { order("id")}
  scope :carrera_id, -> { order("carrera_id asc")}

  
end