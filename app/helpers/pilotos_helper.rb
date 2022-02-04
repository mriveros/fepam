module PilotosHelper

def link_to_editar_piloto(piloto_id)
	
    render partial: 'link_to_editar_piloto', locals: { piloto_id: piloto_id }
    
end
  
end