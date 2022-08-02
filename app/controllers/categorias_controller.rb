class CategoriasController < ApplicationController

	before_filter :require_usuario

	  def index

	  end 

	  def lista

	    cond = []
	    args = []

	    if params[:form_buscar_categorias_id].present?

	      cond << "id = ?"
	      args << params[:form_buscar_categorias_id]

	    end

	    if params[:form_buscar_categorias_descripcion].present?

	      cond << "descripcion ilike ?"
	      args << "%#{params[:form_buscar_categorias_descripcion]}%"

	    end

	    if params[:form_buscar_categorias_nivel].present?

	      cond << "nivel = ?"
	      args << params[:form_buscar_categorias_nivel]

	    end
   

	    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

	    if cond.size > 0

	      @categorias =  Categoria.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
	      @total_encontrados = Categoria.where(cond).count

	    else

	      @categorias = Categoria.orden_01.paginate(per_page: 10, page: params[:page])
	      @total_encontrados = Categoria.count

	    end

	    @total_registros = Categoria.count

	    respond_to do |f|

	      f.js

	    end

	  end


	  def agregar

	    @categoria = Categoria.new

	    respond_to do |f|

	      f.js

	    end

	  end


	  def guardar

	    valido = true
	    @msg = ""

	    @categoria = Categoria.new()

	    @categoria.descripcion = params[:categoria][:descripcion].upcase
	    @categoria.nivel = params[:categoria][:nivel]
	    
	    
	      if @categoria.save

	        auditoria_nueva("registrar Categoria", "categorias", @categoria)
	       
	        @categoria_ok = true
	       

	      end              
	               
	    respond_to do |f|

	      f.js

	    end

	  end


	  def eliminar

	    valido = true
	    @msg = ""

	    @categoria = Categoria.find(params[:id])
		@categoria_elim = @categoria

	    if valido

	      	if @categoria.destroy

		        auditoria_nueva("eliminar Categoria", "categorias", @categoria)
		        @eliminado = true

	    	end
		end

	    respond_to do |f|

	      f.js

	    end

	  end

	  def editar

	    @categoria = Categoria.find(params[:id])

	    respond_to do |f|

	      f.js

	    end

	  end

	  def actualizar

	    valido = true
	    @msg = ""

	    @categoria = Categoria.find(params[:categoria][:id])
	    auditoria_id = auditoria_antes("actualizar Categoria", "categorias", @categoria)

	    if valido

	    	@categoria.descripcion = params[:categoria][:descripcion].upcase
	    	@categoria.nivel = params[:categoria][:nivel]
	      	
	      	if @categoria.save

	      		auditoria_despues(@categoria, auditoria_id)
	        	@categoria_ok = true

	      end

	    end           
	        
	    respond_to do |f|

	      f.js

	    end

	  end
	    

end