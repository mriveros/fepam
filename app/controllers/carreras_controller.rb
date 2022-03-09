class CarrerasController < ApplicationController

	before_filter :require_usuario

	  def index

	  end 

	  def lista

	    cond = []
	    args = []

	    if params[:form_buscar_carreras_id].present?

	      cond << "inscripcion_id = ?"
	      args << params[:form_buscar_carreras_id]

	    end

	    if params[:form_buscar_carreras][:torneo_id].present?

	      cond << "torneo_id = ?"
	      args << params[:form_buscar_carreras][:torneo_id]

	    end

	    if params[:form_buscar_carreras][:torneo_detalle_id].present?

	      cond << "torneo_detalle_id = ?"
	      args << params[:form_buscar_carreras][:torneo_detalle_id]

	    end

	    if params[:form_buscar_carreras][:categoria_id].present?

	      cond << "categoria_id = ?"
	      args << params[:form_buscar_carreras][:categoria_id]

	    end

	    if params[:form_buscar_carreras_fecha_inicio_inscripcion].present?

	      cond << "fecha_inicio_inscripcion = ?"
	      args << params[:form_buscar_carreras_fecha_inicio_inscripcion]

	    end

	    if params[:form_buscar_carreras][:estado_inscripcion_id].present?

	      cond << "estado_inscripcion_id = ?"
	      args << params[:form_buscar_carreras][:estado_inscripcion_id]

	    end

	    

	    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

	    if cond.size > 0

	      @carreras =  VInscripcion.orden_fecha.where(cond).paginate(per_page: 10, page: params[:page])
	      @total_encontrados = VInscripcion.where(cond).count

	    else

	      @carreras = VInscripcion.orden_fecha.paginate(per_page: 10, page: params[:page])
	      @total_encontrados = VInscripcion.count

	    end

	    @total_registros = VInscripcion.count

	    respond_to do |f|

	      f.js

	    end

	  end


	  def agregar

	    @inscripcion = Inscripcion.new

	    respond_to do |f|

	      f.js

	    end

	  end


	  def guardar

	    valido = true
	    @msg = ""

	    #verificar inscripcion
	    @inscripcion = Inscripcion.where('torneo_id = ? and torneo_detalle_id = ? and categoria_id = ?', params[:form_buscar_carreras][:torneo_id],params[:inscripcion][:torneo_detalle_id],params[:inscripcion][:categoria_id]).first
	    if @inscripcion.present?

	    	valido = false
	    	@msg = "La inscripcion ya ha sido habilitada para esta categoría."

	   	end
	   	if valido

		    @inscripcion = Inscripcion.new()
		    @inscripcion.torneo_id = params[:form_buscar_carreras][:torneo_id]
		  	@inscripcion.torneo_detalle_id = params[:inscripcion][:torneo_detalle_id]
		  	@inscripcion.fecha = Date.today
		  	@inscripcion.categoria_id = params[:inscripcion][:categoria_id]
		  	@inscripcion.estado_inscripcion_id = params[:inscripcion][:estado_inscripcion_id]
		    
		      if @inscripcion.save

		        auditoria_nueva("registrar inscripcion", "carreras", @inscripcion)
		        @inscripcion_ok = true
		       
		      end

		end              
	               
	    respond_to do |f|

	      f.js

	    end

	  end


	  def eliminar

	    valido = true
	    @msg = ""

	    @inscripcion = Inscripcion.find(params[:id])
		@inscripcion_elim = @inscripcion

	    if valido
 
	      	if @inscripcion.destroy

		        auditoria_nueva("eliminar inscripcion", "carreras", @inscripcion)
		        @eliminado = true

	    	end
		end

	    respond_to do |f|

	      f.js

	    end

	  end

	  def editar

	    @inscripcion = Inscripcion.find(params[:id])

	    respond_to do |f|

	      f.js

	    end

	  end

	def actualizar

	    valido = true
	    @msg = ""

	    @inscripcion = Inscripcion.find(params[:inscripcion][:id])
	    auditoria_id = auditoria_antes("actualizar inscripcion", "carreras", @inscripcion)

	    if valido

	      
	    	@inscripcion.descripcion = params[:inscripcion][:descripcion].upcase
	    	@inscripcion.cantidad_fechas = params[:inscripcion][:cantidad_fechas]
	    	@inscripcion.fecha = params[:inscripcion][:fecha]
	      	
	      	if @inscripcion.save

	      		auditoria_despues(@inscripcion, auditoria_id)
	        	@inscripcion_ok = true

	      end

	    end           
	        
	    respond_to do |f|

	      f.js

	    end

	end

	def inscripcion_detalle

    @carreras_detalles = VInscripcionDetalle.where("inscripcion_id = ?", params[:inscripcion_id]).paginate(per_page: 10, page: params[:page])
   
    respond_to do |f|

      f.js

    end
    
  end



  def agregar_inscripcion_detalle
    
    @inscripcion_detalle = InscripcionDetalle.new

   respond_to do |f|

      f.js

    end
  
  end


   def guardar_inscripcion_detalle
    
    @valido = true
    @msg = ""
    @guardado_ok = false 

    @inscripcion_detalle = InscripcionDetalle.where('piloto_id=? and inscripcion_id=? and categoria_id =?', params[:piloto_id],params[:inscripcion_id],params[:inscripcion][:categoria_id]).first
    if @inscripcion_detalle.present?
    	puts'########DEBUG'
    	@valido = false
    	@msg = "El piloto ya se ha inscripto en esta Categoría."

   	end 

    if @valido
      
      @inscripcion_detalle = InscripcionDetalle.new()
      @inscripcion_detalle.inscripcion_id = params[:inscripcion_id]
      @inscripcion_detalle.piloto_id = params[:piloto_id]
      @inscripcion_detalle.fecha_inscripcion = params[:fecha_inscripcion]
      @inscripcion_detalle.precio_id = params[:inscripcion][:precio_id]
      @inscripcion_detalle.categoria_id = params[:inscripcion][:categoria_id]

      @inscripcion_detalle.estado_inscripcion_detalle_id = params[:inscripcion][:estado_inscripcion_detalle_id]
      

        if @inscripcion_detalle.save

          auditoria_nueva("registrar piloto en inscripcion", "carreras_detalles", @inscripcion_detalle)
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

  def eliminar_inscripcion_detalle

    @valido = true
    @msg = ""

    @inscripcion_detalle = InscripcionDetalle.find(params[:inscripcion_detalle_id])

    if @valido

      if @inscripcion_detalle.destroy

        auditoria_nueva("eliminar inscripcion detalle", "carreras_detalles", @inscripcion_detalle)

        @eliminado = true

      else

        @msg = "ERROR: No se ha podido eliminar el Piloto de esta Inscripción"

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


	    

end