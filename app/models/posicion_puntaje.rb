class PosicionPuntaje < ActiveRecord::Base
  
  self.table_name= "posiciones_puntajes"
  self.primary_key = "id"
  
  attr_accessible :id, :posicion, :puntaje, :created_at, :updated_at
 
  scope :orden_01, -> { order("id")}
  scope :orden_posicion, -> { order("posicion desc")}

  
end