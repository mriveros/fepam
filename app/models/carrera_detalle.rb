class CarreraDetalle < ActiveRecord::Base
  
  self.table_name= "carreras_detalles"
  self.primary_key = "id"
  
  attr_accessible :id, :carrera_id, :piloto_id, :posicion, :created_at, :updated_at
 
  scope :orden_01, -> { order("id")}
  scope :orden_posicion, -> { order("posicion desc")}

  
end