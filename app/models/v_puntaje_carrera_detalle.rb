class VPuntajeCarreraDetalle < ActiveRecord::Base
  
  self.table_name= "v_puntajes_carreras_detalles"
  self.primary_key = "id"
  
  attr_accessible :id, :puntaje_carrera_id, :piloto_id, :nombre_piloto, :numero, :posicion ,:puntaje_favor, :puntaje_contra, :puntaje_total, :created_at, :updated_at
 
  scope :orden_01, -> { order("id")}
  scope :orden_carrera, -> { order("carrera_id desc")}
  scope :orden_posicion, -> { order("posicion asc")}
  scope :orden_puntaje, -> { order("puntaje_total desc")}

  
end