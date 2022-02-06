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

	    if params[:form_buscar_categorias_sueldo].present?

	      cond << "sueldo = ?"
	      args << params[:form_buscar_categorias_sueldo]

	    end

	    

	    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

	    if cond.size > 0

	      @categorias =  Cargo.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
	      @total_encontrados = Cargo.where(cond).count

	    else

	      @categorias = Cargo.orden_01.paginate(per_page: 10, page: params[:page])
	      @total_encontrados = Cargo.count

	    end

	    @total_registros = Cargo.count

	    respond_to do |f|

	      f.js

	    end

	  end


	  def agregar

	    @cargo = Cargo.new

	    respond_to do |f|

	      f.js

	    end

	  end


	  def guardar

	    valido = true
	    @msg = ""

	    @cargo = Cargo.new()

	    @cargo.descripcion = params[:cargo][:descripcion].upcase
	    @cargo.sueldo = params[:cargo][:sueldo].to_s.gsub(/[$.]/,'').to_i
	    
	      if @cargo.save

	        auditoria_nueva("registrar cargo", "categorias", @cargo)
	       
	        @cargo_ok = true
	       

	      end              
	               
	    respond_to do |f|

	      f.js

	    end

	  end


	  def eliminar

	    valido = true
	    @msg = ""

	    @cargo = Cargo.find(params[:id])
		@cargo_elim = @cargo

	    if valido

	      	if @cargo.destroy

		        auditoria_nueva("eliminar cargo", "categorias", @cargo)
		        @eliminado = true

	    	end
		end

	    respond_to do |f|

	      f.js

	    end

	  end

	  def editar

	    @cargo = Cargo.find(params[:id])

	    respond_to do |f|

	      f.js

	    end

	  end

	  def actualizar

	    valido = true
	    @msg = ""

	    @cargo = Cargo.find(params[:cargo][:id])
	    auditoria_id = auditoria_antes("actualizar cargo", "categorias", @cargo)

	    if valido

	      
	    	@cargo.descripcion = params[:cargo][:descripcion].upcase
	    	@cargo.sueldo = params[:cargo][:sueldo].to_s.gsub(/[$.]/,'').to_i
	      	
	      	if @cargo.save

	      		auditoria_despues(@cargo, auditoria_id)
	        	@cargo_ok = true

	      end

	    end           
	        
	    respond_to do |f|

	      f.js

	    end

	  end
	    

end