class InscripcionesController < ApplicationController

	before_filter :require_usuario

	  def index

	  end 

	  def lista 

	    cond = []
	    args = []

	    if params[:form_buscar_inscripciones_id].present?

	      cond << "inscripcion_id = ?"
	      args << params[:form_buscar_inscripciones_id]

	    end

	    if params[:form_buscar_inscripciones][:torneo_id].present?

	      cond << "torneo_id = ?"
	      args << params[:form_buscar_inscripciones][:torneo_id]

	    end

	    if params[:form_buscar_inscripciones][:torneo_detalle_id].present?

	      cond << "torneo_detalle_id = ?"
	      args << params[:form_buscar_inscripciones][:torneo_detalle_id]

	    end

	    if params[:form_buscar_inscripciones][:categoria_id].present?

	      cond << "categoria_id = ?"
	      args << params[:form_buscar_inscripciones][:categoria_id]

	    end

	    if params[:form_buscar_inscripciones_fecha_inicio_inscripcion].present?

	      cond << "fecha_inicio_inscripcion = ?"
	      args << params[:form_buscar_inscripciones_fecha_inicio_inscripcion]

	    end

	    if params[:form_buscar_inscripciones][:estado_inscripcion_id].present?

	      cond << "estado_inscripcion_id = ?"
	      args << params[:form_buscar_inscripciones][:estado_inscripcion_id]

	    end

	    

	    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

	    if cond.size > 0

	      @inscripciones =  VInscripcion.orden_fecha.where(cond).paginate(per_page: 10, page: params[:page])
	      @total_encontrados = VInscripcion.where(cond).count

	    else

	      @inscripciones = VInscripcion.orden_fecha.paginate(per_page: 10, page: params[:page])
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
	    @inscripcion = Inscripcion.where('torneo_id = ? and torneo_detalle_id = ? and categoria_id = ?', params[:form_buscar_inscripciones][:torneo_id],params[:inscripcion][:torneo_detalle_id], params[:inscripcion][:categoria_id]).first
	    if @inscripcion.present?

	    	valido = false
	    	@msg = "La inscripcion ya ha sido habilitada para esta categoría."

	   	end
	   	if valido

		    @inscripcion = Inscripcion.new()
		    @inscripcion.torneo_id = params[:form_buscar_inscripciones][:torneo_id]
		  	@inscripcion.torneo_detalle_id = params[:inscripcion][:torneo_detalle_id]
		  	@inscripcion.fecha = Date.today
		  	@inscripcion.categoria_id = params[:inscripcion][:categoria_id]
		  	@inscripcion.estado_inscripcion_id = params[:inscripcion][:estado_inscripcion_id]

		    if @inscripcion.save

		    	auditoria_nueva("registrar inscripcion", "inscripciones", @inscripcion)
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

		        auditoria_nueva("eliminar inscripcion", "inscripciones", @inscripcion)
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
	    auditoria_id = auditoria_antes("actualizar inscripcion", "inscripciones", @inscripcion)

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

    @inscripciones_detalles = VInscripcionDetalle.where("inscripcion_id = ?", params[:inscripcion_id]).paginate(per_page: 10, page: params[:page])
   
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

    @inscripcion = Inscripcion.where('id =?',params[:inscripcion_id]).first
    @inscripcion_detalle = InscripcionDetalle.where('piloto_id=? and inscripcion_id=? ', params[:piloto_id],params[:inscripcion_id]).first
    if @inscripcion_detalle.present?
    	
    	@valido = false
    	@guardado_ok = false
    	@msg = " El piloto ya se ha inscripto en esta Categoría."

   	end

   	piloto = Piloto.where('id = ?', params[:piloto_id]).first
   	categoria = Categoria.where('id = ?', @inscripcion.categoria_id).first
   	#if  piloto.nivel <= categoria.nivel

   	#	@valido = false
   	#	@guardado_ok = false
    #	@msg = " El piloto supera el nivel de esta Categoría."

   	#end

    if @valido
      
      @inscripcion_detalle = InscripcionDetalle.new()
      @inscripcion_detalle.inscripcion_id = params[:inscripcion_id]
      @inscripcion_detalle.piloto_id = params[:piloto_id]
      #verificar este issue
      @inscripcion_detalle.fecha_inscripcion = Date.today
      @inscripcion_detalle.precio_id = params[:inscripcion_detalle][:precio_id]
      @inscripcion_detalle.numero = params[:inscripcion_detalle][:numero]
      @inscripcion_detalle.numero_rfid = params[:inscripcion_detalle][:numero_rfid]
      @inscripcion_detalle.estado_inscripcion_detalle_id = params[:inscripcion_detalle][:estado_inscripcion_detalle_id]
      

        if @inscripcion_detalle.save

          auditoria_nueva("registrar piloto en inscripcion", "inscripciones_detalles", @inscripcion_detalle)
          @guardado_ok = true
         
        end 

    end           

    respond_to do |f|

      f.js

    end
  
  end

  def eliminar_inscripcion_detalle

    @valido = true
    @msg = ""

    @inscripcion_detalle = InscripcionDetalle.find(params[:inscripcion_detalle_id])

    @carrera = Carrera.where('inscripcion_id = ? and estado_carrera_id = ?', @inscripcion_detalle.inscripcion_id, PARAMETRO[:estado_carrera_finalizada]).first
    
    if @carrera.present?
    	
    	@carrera_detalle = CarreraDetalle.where('carrera_id = ? and piloto_id = ?',@carrera.id,@inscripcion_detalle.piloto_id).first
    	
    	if @carrera_detalle.present?
    		
    		@valido = false
    		@msg = "Este piloto ya ha participado en la carrera."
    	
    	end
    
    end

    if @valido

      if @inscripcion_detalle.destroy

        auditoria_nueva("eliminar inscripcion detalle", "inscripciones_detalles", @inscripcion_detalle)

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

def buscar_inscripcion
    
    @inscripciones = VInscripcion.where("fecha_campeonato ilike ? and estado_inscripcion_id = ?", "%#{params[:inscripcion]}%", PARAMETRO[:estado_inscripcion_activo])

    respond_to do |f|
      
      f.html
      f.json { render :json => @inscripciones }
    
    end
    
end
	    

end