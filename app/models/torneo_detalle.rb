class TorneoDetalle < ActiveRecord::Base
  
  self.table_name= "torneos_detalles"
  self.primary_key = "id"
  
  attr_accessible :id, :descripcion, :fecha, :created_at, :updated_at,:torneo_id , :estado_torneo_detalle_id
 
  scope :orden_01, -> { order("id")}
  scope :orden_fecha, -> { order("fecha")}
  scope :orden_descripcion, -> { order("descripcion")}

end