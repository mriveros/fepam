class CarreraTiempo < ActiveRecord::Base
  
  self.table_name= "carreras_tiempos"
  self.primary_key = "id"
  
  attr_accessible :id,:carrera_detalle_id, :piloto_id, :tiempo, :cantidad_vueltas, :posicion,  :created_at,:updated_at
 
  scope :orden_01, -> { order("id")}
  scope :orden_vueltas, -> { order("cantidad_vueltas desc")}

end