class VPiloto < ActiveRecord::Base

  self.table_name="v_pilotos"
  self.primary_key="id"
  
  attr_accessible :id, :nombres, :apellidos, :ci, :grupo_sanguineo_id ,:grupo_sanguineo,:direccion, :telefono, :fecha_nacimiento
  
  scope :orden_01, -> { order("id")}
  scope :orden_descripcion, -> { order("nombres, apellidos")}
  
end