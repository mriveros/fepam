class VInscripcion < ActiveRecord::Base
  
  self.table_name= "v_inscripciones"
  self.primary_key = "id"
  
  attr_accessible :id, :torneo_detalle_id, :torneo, :fecha, :estado_inscripcion_id, :estado_inscripcion ,:categoria_id, :categoria, :created_at, :updated_at, :fecha_inicio_inscripcion
 
  scope :orden_01, -> { order("id")}
  scope :orden_fecha, -> { order("fecha_inicio_inscripcion desc")}

end