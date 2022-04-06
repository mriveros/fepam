class Piloto < ActiveRecord::Base

  self.table_name="pilotos"
  self.primary_key="id"
  include Gravtastic
  gravtastic
  attr_accessible :id, :nombres, :apellidos, :ci, :grupo_sanguineo_id, :direccion, :telefono, :fecha_nacimiento, :avatar_url
  
  scope :orden_01, -> { order("id")}
  scope :orden_descripcion, -> { order("nombres, apellidos")}
  
end