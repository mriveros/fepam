module TorneosHelper

  def link_to_editar_torneo(torneo)

      render partial: 'link_to_editar_torneo', locals: { torneo: torneo }
      
  end

  def link_to_torneo_detalle(torneo_id)

      render partial: 'link_to_torneo_detalle', locals: { torneo_id: torneo_id }
      
  end

  
end