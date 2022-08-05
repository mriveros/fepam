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

	    if params[:form_buscar_torneos_fecha].present?

	      cond << "fecha = ?"
	      args << params[:form_buscar_torneos_fecha]

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

		torneo_detalle = TorneoDetalle.where('torneo_id = ?', params[:id])
		if torneo_detalle.present?

			valido = false
			@msg = 'El Campeonato ya cuenta con fechas.'

		end

	    if valido

	      	if @torneo.destroy

		        auditoria_nueva("eliminar torneo", "torneos", @torneo)
		        @eliminado = true

	    	end
		end

		rescue Exception => exc  
	    # dispone el mensaje de error 
	    #puts "Aqui si muestra el error ".concat(exc.message)
	      if exc.present?        
	        @excep = exc.message.split(':')
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

	def torneo_detalle

    @torneos_detalles = TorneoDetalle.where("torneo_id = ?", params[:torneo_id]).paginate(per_page: 10, page: params[:page])
   
    respond_to do |f|

      f.js

    end
    
  end



  def agregar_torneo_detalle
    
    @torneo_detalle = TorneoDetalle.new

   respond_to do |f|

      f.js

    end
  
  end


   def guardar_torneo_detalle
    
    @valido = true
    @msg = ""
    @guardado_ok = false

    unless params[:torneo_detalle][:descripcion].present?

      @valido = false
      @msg += " Debe Completar el campo descripción. \n"

    end

    unless params[:torneo_detalle][:fecha].present?

      @valido = false
      @msg += " Debe agregar una fecha. \n"

    end

    

    if @valido
      
      @torneo_detalle = TorneoDetalle.new()
      @torneo_detalle.descripcion = params[:torneo_detalle][:descripcion].upcase
      @torneo_detalle.fecha = params[:torneo_detalle][:fecha]
      @torneo_detalle.torneo_id = params[:torneo_id]

        if @torneo_detalle.save

          auditoria_nueva("registrar torneo asignado a hacienda", "torneos", @torneo_detalle)
          @guardado_ok = true
         
        end 

    end
  
    rescue Exception => exc  
    # dispone el mensaje de error 
    #puts "Aqui si muestra el error ".concat(exc.message)
      if exc.present?        
        @excep = exc.message.split(':')    
        @msg = @excep
      
      end                

    respond_to do |f|

      f.js

    end
  
  end

  def eliminar_torneo_detalle

    @valido = true
    @msg = ""

    @torneo_detalle = TorneoDetalle.find(params[:torneo_id])

    if @valido

      if @torneo_detalle.destroy

        auditoria_nueva("eliminar fecha del campeonato", "torneos", @torneo_detalle)

        @eliminado = true

      else

        @msg = "ERROR: No se ha podido eliminar el torneo del campeonato porque ya cuenta con registros"

      end

    end

        rescue Exception => exc  
        # dispone el mensaje de error 
        #puts "Aqui si muestra el error ".concat(exc.message)
        if exc.present?        
          
          @excep = exc.message.split(':')    
          @msg = @excep
          @eliminado = false
        
        end
        
    respond_to do |f|

      f.js

    end
  
  end  

  def buscar_torneo_detalle

    if params[:form_buscar_inscripciones_torneo_id].present?
      
       @torneo_detalle = TorneoDetalle.where("torneo_id = ? and estado_torneo_detalle_id = ?", params[:form_buscar_inscripciones_torneo_id], PARAMETRO[:estado_torneo_detalle_activo])
    
    end

    respond_to do |f|
      
      f.json { render :json => @torneo_detalle }
    
    end
  
  end  

  def finalizar_campeonato
  	
  	@torneo =  Torneo.where('id = ?', params[:torneo_id]).first
  	@torneo_detalle = TorneoDetalle.where('torneo_id = ?', params[:torneo_id])
	



	respond_to do |f|

		f.js
  
	end

  end

end