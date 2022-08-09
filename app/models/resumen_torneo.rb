class ResumenTorneo < ActiveRecord::Base
  
  self.table_name= "resumenes_torneos"
  self.primary_key = "id"
  
  attr_accessible :id,:torneo_id,:piloto_id,:puntaje_total, :created_at, :updated_at
 
  scope :orden_01, -> { order("id")}
  scope :torneo, -> { order("torneo_id desc")}

end