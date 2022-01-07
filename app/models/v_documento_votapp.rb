class VDocumentoVotapp < ActiveRecord::Base

  self.table_name="v_documentos_votapp"
  self.primary_key="documento_votapp_id"
  
  
  attr_accessible :documento_votapp_id, :numero, :descripcion, :fecha_emision, :tipo_resolucion_id, :tipo_resolucion, :data, :habilitado, :eleccion_id, :eleccion
  
  belongs_to :tipo_resolucion_documento
  scope :orden_id, -> {order("documento_votapp_id")}
  has_attached_file :data
  validates_attachment_content_type :data, :content_type => ['application/pdf', 'application/binary', 'image/jpeg']
 
  
end