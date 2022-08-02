class Categoria < ActiveRecord::Base
  
  self.table_name= "categorias"
  self.primary_key = "id"
  
  attr_accessible :id, :descripcion, :created_at, :updated_at, :nivel
 
  scope :orden_01, -> { order("id")}
  scope :orden_descripcion, -> { order("descripcion")}

end