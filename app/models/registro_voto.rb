class RegistroVoto < ActiveRecord::Base

  self.table_name="registros_votos"
  self.primary_key="id"
  
  attr_accessible :id, :votante_id, :fecha_registro, :eleccion_id, :usuario_id, :created_at, :updated_at
  
  scope :orden_01, -> { order("id")}

  def self.voto_percentage
  
  	RegistroVoto.all.count.to_f * 100 / Votante.all.count.to_f
  
  end
  
end