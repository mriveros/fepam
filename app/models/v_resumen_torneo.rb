class VResumenTorneo < ActiveRecord::Base
  
  self.table_name= "v_resumenes_torneos"
  self.primary_key = "torneo_id"
  
  attr_accessible :torneo_id, :torneo,:piloto_id, :nombres , :apellidos , :categoria_id, :categoria, :puntaje_sumatoria 
 
  scope :orden_01, -> { order("torneo_id")}

  
end