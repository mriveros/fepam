class Inscripcion < ActiveRecord::Base
  
  self.table_name= "inscripciones"
  self.primary_key = "id"
  
  attr_accessible :id, :descripcion, :cantidad_fechas, :fecha, :created_at, :updated_at
 
  scope :orden_01, -> { order("id")}
  scope :orden_descripcion, -> { order("descripcion")}

end