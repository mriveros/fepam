class Torneo < ActiveRecord::Base
  
  self.table_name= "torneos"
  self.primary_key = "id"
  
  attr_accessible :id, :descripcion, :cantidad_fechas, :created_at, :updated_at
 
  scope :orden_01, -> { order("id")}
  scope :orden_descripcion, -> { order("descripcion")}

end