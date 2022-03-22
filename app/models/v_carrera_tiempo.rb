class VCarreraTiempo < ActiveRecord::Base
  
  self.table_name= "v_carreras_tiempos"
  self.primary_key = "piloto_id"
  
  attr_accessible :piloto_id,:tiempos, :carrera_id, :max
 
  scope :orden_piloto, -> { order("piloto_id desc")}
  scope :orden_tiempo, -> { order("tiempos desc")}
  scope :orden_vuelta_tiempo, -> { order("max desc, tiempos asc")}

end