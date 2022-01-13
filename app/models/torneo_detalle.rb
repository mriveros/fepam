class TorneoDetalle < ActiveRecord::Base
  
  self.table_name= "torneos_detalles"
  self.primary_key = "id"
  
  attr_accessible :id, :descripcion, :fecha, :created_at, :updated_at
 
  scope :orden_01, -> { order("id")}
  scope :orden_fecha, -> { order("fecha")}

end