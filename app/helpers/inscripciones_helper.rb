module InscripcionesHelper

  def link_to_editar_inscripcion(inscripcion)

      render partial: 'link_to_editar_inscripcion', locals: { inscripcion: inscripcion }
      
  end

  def link_to_inscripcion_detalle(inscripcion_id)

      render partial: 'link_to_inscripcion_detalle', locals: { inscripcion_id: inscripcion_id }
      
  end

  
end