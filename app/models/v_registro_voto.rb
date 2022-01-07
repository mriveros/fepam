class VRegistroVoto < ActiveRecord::Base

  self.table_name="v_registros_votos"
  self.primary_key="registro_voto_id"
  
  attr_accessible :registro_voto_id, :eleccion_id, :eleccion,  :fecha_registro, :votante_id, :cedula, :nombres, :apellidos,:direccion, :partido, :seccional_id, :seccional, :departamento_id, :departamento, :usuario_id, :usuario_insercion, :usuario_id, :created_at, :updated_at
  
  scope :orden_01, -> { order("registro_voto_id")}
  
end