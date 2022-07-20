class VResumenPuntajeCarrera < ActiveRecord::Base
  
  self.table_name= "v_resumen_puntajes_carreras"
  self.primary_key = "resumen_puntaje_id"
  
  attr_accessible :resumen_puntaje_id, :carrera_id, :piloto_id, :datos_piloto, :posicion, :puntaje, :created_at
 
  scope :orden_01, -> { order("resumen_puntaje_id")}
  scope :carrera_id, -> { order("carrera_id asc")}

  
end