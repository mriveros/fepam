class TorneosController < ApplicationController

	before_filter :require_usuario

	  def index

	  end

	  def lista

	    cond = []
	    args = []

	    if params[:form_buscar_torneos_id].present?

	      cond << "id = ?"
	      args << params[:form_buscar_torneos_id]

	    end

	    if params[:form_buscar_torneos_descripcion].present?

	      cond << "descripcion ilike ?"
	      args << "%#{params[:form_buscar_torneos_descripcion]}%"

	    end

	    if params[:form_buscar_torneos_cantidad_fechas].present?

	      cond << "cantidad_fechas = ?"
	      args << params[:form_buscar_torneos_cantidad_fechas]

	    end

	    

	    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

	    if cond.size > 0

	      @torneos =  Torneo.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
	      @total_encontrados = Torneo.where(cond).count

	    else

	      @torneos = Torneo.orden_01.paginate(per_page: 10, page: params[:page])
	      @total_encontrados = Torneo.count

	    end

	    @total_registros = Torneo.count

	    respond_to do |f|

	      f.js

	    end

	  end


	  def agregar

	    @torneo = Torneo.new

	    respond_to do |f|

	      f.js

	    end

	  end


	  def guardar

	    valido = true
	    @msg = ""

	    @torneo = Torneo.new()

	    @torneo.descripcion = params[:torneo][:descripcion].upcase
	  	@torneo.cantidad_fechas = params[:torneo][:cantidad_fechas]
	  	@torneo.fecha = params[:torneo][:fecha]
	    
	      if @torneo.save

	        auditoria_nueva("registrar torneo", "torneos", @torneo)
	       
	        @torneo_ok = true
	       

	      end              
	               
	    respond_to do |f|

	      f.js

	    end

	  end


	  def eliminar

	    valido = true
	    @msg = ""

	    @torneo = Torneo.find(params[:id])
		@torneo_elim = @torneo

	    if valido

	      	if @torneo.destroy

		        auditoria_nueva("eliminar torneo", "torneos", @torneo)
		        @eliminado = true

	    	end
		end

	    respond_to do |f|

	      f.js

	    end

	  end

	  def editar

	    @torneo = Torneo.find(params[:id])

	    respond_to do |f|

	      f.js

	    end

	  end

	  def actualizar

	    valido = true
	    @msg = ""

	    @torneo = Torneo.find(params[:torneo][:id])
	    auditoria_id = auditoria_antes("actualizar torneo", "torneos", @torneo)

	    if valido

	      
	    	@torneo.descripcion = params[:torneo][:descripcion].upcase
	    	@torneo.cantidad_fechas = params[:torneo][:cantidad_fechas]
	    	@torneo.fecha = params[:torneo][:fecha]
	      	
	      	if @torneo.save

	      		auditoria_despues(@torneo, auditoria_id)
	        	@torneo_ok = true

	      end

	    end           
	        
	    respond_to do |f|

	      f.js

	    end

	  end
	    

end