class VCarrera < ActiveRecord::Base
  
  self.table_name= "v_carreras"
  self.primary_key = "carrera_id"
  
  attr_accessible :carrera_id,:inscripcion_id,:fecha_carrera,:torneo,:fecha,:categoria_id,:categoria,:estado_carrera_id,:estado_carrera,:created_at,:updated_at
 
  scope :orden_01, -> { order("carrera_id")}
  scope :orden_fecha, -> { order("created_at desc")}

end