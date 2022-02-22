class EstadoInscripcion < ActiveRecord::Base
  
  self.table_name= "estados_inscripciones"
  self.primary_key = "id"
  
  attr_accessible :id, :descripcion, :created_at, :updated_at
 
  scope :orden_01, -> { order("id")}
  scope :orden_descripcion, -> { order("descripcion")}

  
end