module TorneosHelper

  def link_to_editar_torneo(torneo)

      render partial: 'link_to_editar_torneo', locals: { torneo: torneo }
      
  end

  
end