module VotantesHelper

  def link_to_editar_votante(votante)

      render partial: 'link_to_editar_votante', locals: { votante: votante }
      
  end

  
end