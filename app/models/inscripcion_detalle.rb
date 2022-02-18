class InscripcionDetalle < ActiveRecord::Base
  
  self.table_name= "inscripciones_detalles"
  self.primary_key = "id"
  
  attr_accessible :id, :piloto_id, :fecha_inscripcion, :created_at, :updated_at
 
  scope :orden_01, -> { order("id")}
  scope :orden_descripcion, -> { order("descripcion")}

end