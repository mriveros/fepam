module PilotosHelper

def link_to_editar_piloto(piloto)

    render partial: 'link_to_editar_piloto', locals: { piloto: piloto }
    
end
  
end