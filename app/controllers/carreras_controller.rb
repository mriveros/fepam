class CarrerasController < ApplicationController

	before_filter :require_usuario

	  def index

	  end 

	  def lista

	    cond = []
	    args = []

	    if params[:form_buscar_carreras_id].present?

	      cond << "carrera_id = ?"
	      args << params[:form_buscar_carreras_id]

	    end

	    if params[:form_buscar_carreras][:inscripcion_id].present?

	      cond << "inscripcion_id = ?"
	      args << params[:form_buscar_carreras][:inscripcion_id]

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

	      @carreras =  VCarrera.orden_fecha.where(cond).paginate(per_page: 10, page: params[:page])
	      @total_encontrados = VCarrera.where(cond).count

	    else

	      @carreras = VCarrera.orden_fecha.paginate(per_page: 10, page: params[:page])
	      @total_encontrados = VCarrera.count

	    end

	    @total_registros = VCarrera.count

	    respond_to do |f|

	      f.js

	    end

	  end


	def agregar

	    @carrera = Carrera.new

	    respond_to do |f|

	      f.js

	    end

	  end


	def guardar

	    valido = true
	    @msg = ""
	   
	   	if valido
 
		    @carrera = Carrera.new()
		    @carrera.inscripcion_id = params[:inscripcion_id]
		  	@carrera.fecha = params[:fecha_carrera]
		  	@carrera.estado_carrera_id = params[:carrera][:estado_carrera_id]
		    
		    if @carrera.save

		        auditoria_nueva("registrar carrera", "carreras", @carrera)

		        #cargar pilotos
		        inscripcion_detalle = InscripcionDetalle.where('inscripcion_id = ? and estado_inscripcion_detalle_id = ?', params[:inscripcion_id], PARAMETRO[:estado_inscripcion_detalle_pagado])
		        inscripcion_detalle.each do |id|

			        carrera_detalle = CarreraDetalle.new()
			        carrera_detalle.piloto_id = id.piloto_id
			        carrera_detalle.carrera_id = @carrera.id
			        if carrera_detalle.save

			        	@carrera_ok = true

			       	end

		       	end
		       
		    end

		end              
	               
	    respond_to do |f|

	      f.js

	    end

	end


	def eliminar

	    valido = true
	    @msg = ""

	    @carrera = Carrera.find(params[:id])
		@carrera_elim = @carrera

	    if valido
 
	      	if @carrera.destroy

		        auditoria_nueva("eliminar carrera", "carreras", @carrera_elim)
		        @eliminado = true

	    	end
		end

		rescue Exception => exc  
    
	      if exc.present?        
	        @excep = exc.message.split(':')    
	        @msg = 'La Carrera ya cuenta con inscriptos'
	      
	      end       

	    respond_to do |f|

	      f.js

	    end

	end


	def carrera_detalle

    	@carreras_detalles = VCarreraDetalle.orden_posicion.where("carrera_id = ?", params[:carrera_id]).paginate(per_page: 50, page: params[:page])
   
	    respond_to do |f|

	      f.js

	    end
    
  	end

	def marcar_tiempo

	    @valido = true
	    @msg = ""

	    @carrera_detalle = CarreraDetalle.find(params[:carrera_detalle_id])
	    time = Time.new
	    @carrera_tiempo = CarreraTiempo.new()
	    @carrera_tiempo.carrera_detalle_id = params[:carrera_detalle_id]
	    @carrera_tiempo.carrera_id = @carrera_detalle.carrera_id
	    @carrera_tiempo.piloto_id = params[:piloto_id]
	    #calcular cantidad vueltas
	    cdt = CarreraTiempo.where('carrera_detalle_id = ? and piloto_id = ?', params[:carrera_detalle_id],params[:piloto_id]).count
	    @carrera_tiempo.cantidad_vueltas = cdt + 1
	    @carrera_tiempo.tiempo = time.strftime("%H:%M:%S")
	   	@carrera_tiempo.save
	   	#calcular posicion
	   	posicion_piloto = VCarreraTiempo.orden_tiempo.where('carrera_id = ?', @carrera_detalle.carrera_id)
		if posicion_piloto.find(params[:piloto_id]).present?	
			@carrera_tiempo.posicion = posicion_piloto.find(params[:piloto_id]).posicion   
	    end

	    if @carrera_tiempo.save

	    	@tiempo_marcado_ok = true

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

	def penalizar_piloto

	    @valido = true
	    @msg = ""

	    @carrera_detalle = CarreraDetalle.find(params[:carrera_detalle_id])
	    time = Time.new
	    @carrera_penalizar = CarreraPenalizar.new()
	    @carrera_penalizar.carrera_detalle_id = params[:carrera_detalle_id]
	    @carrera_penalizar.carrera_id = @carrera_detalle.carrera_id
	    @carrera_penalizar.piloto_id = params[:piloto_id]
	    @carrera_penalizar.cantidad_puntos = PARAMETRO[:penalizar_piloto_1_punto]
	    @carrera_penalizar.tiempo = time.strftime("%H:%M:%S")
	    if @carrera_penalizar.save

	    	@piloto_penalizado_ok = true

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

	def finalizar_carrera

	    valido = true
	    @msg = ""
	    @finalizar_carrera_ok

	    @carrera = Carrera.find(params[:carrera_id])

		@carrera_detalle = CarreraDetalle.where('carrera_id = ?', params[:carrera_id])
		#CALCULAR POSICIONES FINALES
		@carrera_detalle.each do |cd|

			carrera_tiempo_posicion_max = VCarreraTiempo.where('piloto_id = ?', cd.piloto_id).first
			cd.posicion = carrera_tiempo_posicion_max.posicion
			cd.save
			
		end
		#CREAR PUNTAJE
		puntaje_carrera = PuntajeCarrera.new
		puntaje_carrera.carrera_id = params[:carrera_id]
		puntaje_carrera.fecha = Date.today
		if puntaje_carrera.save

			@finalizar_carrera_ok = true
		
		else

			@finalizar_carrera_ok = false

		end

		#CREAR PUNTAJE DETALLE
		@carrera_detalle.each do |cd|

			puntaje_carrera_detalle = PuntajeCarreraDetalle.new
			puntaje_carrera_detalle.puntaje_carrera_id = puntaje_carrera.id
			puntaje_carrera_detalle.piloto_id = cd.piloto_id
			#obtener puntaje a favor
			puntaje_favor = PosicionPuntaje.where('posicion = ?', cd.posicion).first
			if puntaje_favor.present?

				puntaje_carrera_detalle.puntaje_favor = puntaje_favor.puntaje

			else

				puntaje_carrera_detalle.puntaje_favor = 1

			end
			#objetener puntaje en contra
			puntaje_contra = CarreraPenalizacion.where('carrera_id = ? and piloto_id = ?',params[:carrera_id], cd.piloto_id)
			if puntaje_contra.present?

				puntaje_carrera_detalle.puntaje_contra = 2
			
			else

				puntaje_carrera_detalle.puntaje_contra = 0

			end

			puntaje_carrera_detalle.puntaje_total = puntaje_favor.puntaje - 2

			if puntaje_carrera_detalle.save


				@finalizar_carrera_ok = true
		
			else

				@finalizar_carrera_ok = false

			end

		end

	    if valido
 			
 			@carrera.estado_carrera_id = PARAMETRO[:estado_carrera_finalizada]
 			if @carrera.save

 				@finalizar_carrera_ok = true

			end

		end

		rescue Exception => exc
    
	      if exc.present?

	        @excep = exc.message.split(':')
	        @msg = 'No se pudo calcular la carrera.'
	      
	      end       

	    respond_to do |f|

	      f.js

	    end

	end
  
end
	    