class VInscripcionDetalle < ActiveRecord::Base
  
  self.table_name= "v_inscripciones_detalles"
  self.primary_key = "inscripcion_detalle_id"
  
  attr_accessible :inscripcion_detalle_id, :inscripcion_id ,:piloto_id, :nombre_piloto, :precio_id, :monto_inscricion, :estado_inscripcion_detalle_id, :estado_inscripcion_detalle, :nombre_piloto, :fecha_inscripcion, :created_at, :updated_at
 
  scope :orden_01, -> { order("inscripcion_detalle_id")}
  scope :orden_nombre_piloto, -> { order("nombre_piloto")}

end