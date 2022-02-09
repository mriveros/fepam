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

	    @Categoria = Categoria.new

	    respond_to do |f|

	      f.js

	    end

	  end


	  def guardar

	    valido = true
	    @msg = ""

	    @Categoria = Categoria.new()

	    @Categoria.descripcion = params[:Categoria][:descripcion].upcase
	    @Categoria.sueldo = params[:Categoria][:sueldo].to_s.gsub(/[$.]/,'').to_i
	    
	      if @Categoria.save

	        auditoria_nueva("registrar Categoria", "categorias", @Categoria)
	       
	        @Categoria_ok = true
	       

	      end              
	               
	    respond_to do |f|

	      f.js

	    end

	  end


	  def eliminar

	    valido = true
	    @msg = ""

	    @Categoria = Categoria.find(params[:id])
		@Categoria_elim = @Categoria

	    if valido

	      	if @Categoria.destroy

		        auditoria_nueva("eliminar Categoria", "categorias", @Categoria)
		        @eliminado = true

	    	end
		end

	    respond_to do |f|

	      f.js

	    end

	  end

	  def editar

	    @Categoria = Categoria.find(params[:id])

	    respond_to do |f|

	      f.js

	    end

	  end

	  def actualizar

	    valido = true
	    @msg = ""

	    @Categoria = Categoria.find(params[:Categoria][:id])
	    auditoria_id = auditoria_antes("actualizar Categoria", "categorias", @Categoria)

	    if valido

	      
	    	@Categoria.descripcion = params[:Categoria][:descripcion].upcase
	    	@Categoria.sueldo = params[:Categoria][:sueldo].to_s.gsub(/[$.]/,'').to_i
	      	
	      	if @Categoria.save

	      		auditoria_despues(@Categoria, auditoria_id)
	        	@Categoria_ok = true

	      end

	    end           
	        
	    respond_to do |f|

	      f.js

	    end

	  end
	    

end