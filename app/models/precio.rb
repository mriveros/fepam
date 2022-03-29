class Precio < ActiveRecord::Base
  
  self.table_name= "precios"
  self.primary_key = "id"
  
  attr_accessible :id, :descripcion, :monto, :created_at, :updated_at
 
  scope :orden_01, -> { order("id")}

  scope :monto_descripcion, -> { select("descripcion || ' ' || 'Gs.' || monto as descripcion")}

  
end