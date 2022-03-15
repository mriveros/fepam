class VCarreraDetalle < ActiveRecord::Base
  
  self.table_name= "v_carreras_detalles"
  self.primary_key = "carrera_detalle_id"
  
  attr_accessible :carrera_detalle_id,:carrera_id,:piloto_id, :datos_piloto, :numero_piloto, :posicion,  :created_at,:updated_at
 
  scope :orden_01, -> { order("carrera_detalle_id")}
  scope :orden_fecha, -> { order("posicion desc")}

end