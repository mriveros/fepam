class DocumentoFepam < ActiveRecord::Base

  self.table_name="documentos_fepam"
  self.primary_key="id"
  
  
  attr_accessible :id, :numero, :descripcion, :fecha_emision, :tipo_resolucion_id, :data, :habilitado, :eleccion_id
  
  belongs_to :tipo_resolucion_documento
  scope :orden_id, -> {order("id")}
  has_attached_file :data
  validates_attachment_content_type :data, :content_type => ['application/pdf', 'application/binary', 'image/jpeg', 'image/png']
 
  
end