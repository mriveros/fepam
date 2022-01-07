class VotoLider < ActiveRecord::Base
  
  self.table_name= "lideres"
  self.primary_key = "id"
  
  attr_accessible :id, :nombre_lider, :apellido_lider, :seccional_id, :created_at, :updated_at
 
  scope :orden_01, -> { order("id")}
  scope :orden_seccional, -> { order("seccional_id")}

end