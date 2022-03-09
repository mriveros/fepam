class VCarrera < ActiveRecord::Base
  
  self.table_name= "v_carreras"
  self.primary_key = "carrera_id"
  
  attr_accessible :carrera_id, :inscripcion_id, :torneo_id, :torneo, :torneo_detalle_id, :torneo_detalle, :categoria_id, :categoria, :created_at, :updated_at
 
  scope :orden_01, -> { order("carrera_id")}
  scope :orden_torneo_id, -> { order("orden_torneo_id desc")}

end