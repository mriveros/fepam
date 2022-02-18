class VInscripcionDetalle < ActiveRecord::Base
  
  self.table_name= "v_inscripciones_detalles"
  self.primary_key = "inscripcion_detalle_id"
  
  attr_accessible :inscripcion_detalle_id, :piloto_id, :precio_id, :precio, :estado_inscripcion_id, :estado_inscripcion, :nombre_piloto, :apellido_piloto, :fecha_inscripcion, :created_at, :updated_at
 
  scope :orden_01, -> { order("id_detalle_id")}
  scope :orden_nombre_piloto, -> { order("nombre_piloto, apellido_piloto")}

end