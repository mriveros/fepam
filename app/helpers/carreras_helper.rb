module CarrerasHelper

  def link_to_editar_carrera(carrera)

      render partial: 'link_to_editar_carrera', locals: { carrera: carrera }
      
  end

  def link_to_carrera_detalle(carrera_id)

      render partial: 'link_to_carrera_detalle', locals: { carrera_id: carrera_id }
      
  end

  def link_to_puntaje_carrera(carrera_id)

      render partial: 'link_to_puntaje_carrera', locals: { carrera_id: carrera_id }
      
  end

  
end