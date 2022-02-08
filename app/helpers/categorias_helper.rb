module CategoriasHelper

  def link_to_editar_categoria(categoria)

      render partial: 'link_to_editar_categoria', locals: { categoria: categoria }
      
  end

  
end