class VPiloto < ActiveRecord::Base

  self.table_name="v_pilotos"
  self.primary_key="id"

  extend Dragonfly::Model
  include Avatarable

  dragonfly_accessor :photo
  attr_accessor :image_uid

  attr_accessible :piloto_id, :nombres, :apellidos, :ci, :grupo_sanguineo_id ,:grupo_sanguineo,:direccion, :telefono, :fecha_nacimiento
  
  def full_name
    [nombres, apellidos].join(' ')
  end

  # required for avatarable
  def avatar_text
    nombres.chr
  end
  
  scope :orden_01, -> { order("piloto_id")}
  scope :orden_descripcion, -> { order("nombres, apellidos")}
  
end