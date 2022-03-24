class CarreraPenalizar < ActiveRecord::Base
  
  self.table_name= "carreras_penalizaciones"
  self.primary_key = "id"
  
  attr_accessible :id,:carrera_detalle_id, :carrera_id, :piloto_id, :cantidad_puntos, :tiempo, :created_at, :updated_at
 
  scope :orden_piloto, -> { order("piloto_id desc")}
  scope :orden_id, -> { order("id asc")}

end