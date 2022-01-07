class SeleccionVoto < ActiveRecord::Base
  
  self.table_name= "selecciones_votos"
  self.primary_key = "id"
  
  attr_accessible :id, :descripcion, :created_at, :updated_at
 
  scope :orden_01, -> { order("id")}
  scope :orden_descripcion, -> { order("descripcion asc")}

  
end