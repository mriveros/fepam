class VotoLider < ActiveRecord::Base
  
  self.table_name= "votos_lideres"
  self.primary_key = "id"
  
  attr_accessible :id, :cedula, :lider_id, :seccional_id,:created_at, :updated_at
 
  scope :orden_01, -> { order("id")}
  scope :orden_descripcion, -> { order("lider_id")}

end