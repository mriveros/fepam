class CarrerasController < ApplicationController
	
	require 'serialport'

	before_filter :require_usuario, except: [:conectar_puerto_serie, :iniciar_carrera]

	  def index

	  end 

	  def lista

	    cond = []
	    args = []

	    if params[:form_buscar_carreras_id].present?

	      cond << "carrera_id = ?"
	      args << params[:form_buscar_carreras_id]

	    end

	    if params[:form_buscar_carreras_torneo].present?

	      cond << "torneo ilike ?"
	      args << "%#{params[:form_buscar_carreras_torneo]}%"

	    end

	    if params[:form_buscar_carreras_inscripcion].present?

	      cond << "inscripcion ilike ?"
	      args << "%#{params[:form_buscar_carreras_inscripcion]}%"

	    end

	    if params[:form_buscar_carreras_fecha_carrera].present?

	      cond << "fecha_carrera = ?"
	      args << params[:form_buscar_carreras_fecha_carrera]

	    end

	    if params[:form_buscar_carreras][:categoria_id].present?

	      cond << "categoria_id = ?"
	      args << params[:form_buscar_carreras][:categoria_id]

	    end

	    if params[:form_buscar_carreras_tiempo].present?

	      cond << "tiempo = ?"
	      args << params[:form_buscar_carreras_tiempo]

	    end

	    if params[:form_buscar_carreras][:estado_carrera_id].present?

	      cond << "estado_carrera_id = ?"
	      args << params[:form_buscar_carreras][:estado_carrera_id]

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
		  	@carrera.fecha = Date.today
		  	@carrera.estado_carrera_id = params[:carrera][:estado_carrera_id]
		  	@carrera.tiempo = params[:carrera][:tiempo]
		    
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

		@carrera = Carrera.find(params[:carrera_id])
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

	def conectar_puerto_serie(carrera)
	  puts "tiempo"
	  puts carrera.tiempo
	  puerto = '/dev/ttyACM0'  # Nombre del puerto serie
	  velocidad = 115200       # Velocidad de baudios
	  tiempo_ejecucion = 30 #(carrera.tiempo * 60) # multiplicamos por 60 para convertir en segundos
	 
	  begin
	    # Abrir una conexión al puerto serie
	    serial_port = SerialPort.new(puerto, velocidad)
	    puts "Conexión al puerto serie establecida correctamente."

	    # Leer datos del puerto serie continuamente
	    Timeout.timeout(tiempo_ejecucion) do
		    loop do
		      # Leer una línea del puerto serie
		      linea = serial_port.gets.chomp
		      # Imprimir la línea recibida
			    begin
			        linea = linea.force_encoding('UTF-8')
			        
			        if linea.include?("EPC")

			        	@numero_rfid = linea.split(":")[1]

			    	end

			      	rescue Encoding::UndefinedConversionError
			        # Si la conversión a UTF-8 falla, descartar la línea
			        puts "La línea no es de tipo UTF-8. Se descarta."
			        next

			    end

			    if @numero_rfid != @ultimo_numero_rfid

			    	#Este control es medianamente viable
			    	@ultimo_numero_rfid = @numero_rfid
			    	inscripcion_detalle = InscripcionDetalle.where('numero_rfid = ?',@numero_rfid).first

			    	if inscripcion_detalle.present?
				    	
				    	carrera_detalle = CarreraDetalle.where('carrera_id = ? and piloto_id = ?', carrera.id, inscripcion_detalle.piloto_id).first

				    	#En esta parte se tiene que registrar en la carrera como una vuelta realizada
					    time = Time.new
					    @carrera_tiempo = CarreraTiempo.new()
					    @carrera_tiempo.carrera_detalle_id = carrera_detalle.id
					    @carrera_tiempo.carrera_id = carrera.id
					    @carrera_tiempo.piloto_id = carrera_detalle.piloto_id
					    @carrera_tiempo.tiempo = time.strftime("%H:%M:%S")
					   	@carrera_tiempo.tag_rfid = inscripcion_detalle.numero_rfid
					   	@carrera_tiempo.save
					   	#calcular posicion
					   	posicion_piloto = VCarreraTiempo.orden_tiempo.where('carrera_id = ?', carrera_detalle.carrera_id)
						if posicion_piloto.find(carrera_detalle.piloto_id).present?	

							@carrera_tiempo.posicion = posicion_piloto.find(carrera_detalle.piloto_id).posicion   

					    end

					    if @carrera_tiempo.save

					    	@tiempo_marcado_ok = true

					    end

					end

			    	
			  	end
		    
		   end

		end
	   
	   
	   rescue Timeout::Error
    	
    	puts "El tiempo de ejecución ha terminado. La conexión se cerrará."

	  rescue => e
	  
	    puts "Error al conectar al puerto serie: #{e.message}"
	  
	  ensure
	  
	    # Cerrar la conexión al puerto serie cuando hayamos terminado
	    serial_port.close if serial_port
	    puts "Conexión al puerto serie cerrada."
	  
	  end

	end


	def iniciar_carrera

	    @msg = ""
	    # Llamar a la función para conectar al puerto serie
	    @carrera = Carrera.find(params[:carrera_id])    
	    #@carrera.estado_carrera_id = PARAMETRO[:estado_carrera_iniciado]
	    
	    if @carrera.save
	    	
	    	@iniciar_carrera_ok = true
	    	conectar_puerto_serie(@carrera)

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

		#CREAR PUNTAJE
		puntaje_carrera = PuntajeCarrera.where('carrera_id = ?', params[:carrera_id]).first
		unless puntaje_carrera.present?

			puntaje_carrera = PuntajeCarrera.new
			puntaje_carrera.carrera_id = params[:carrera_id]
			puntaje_carrera.fecha = Date.today
			if puntaje_carrera.save

				@finalizar_carrera_ok = true
			
			else

				@finalizar_carrera_ok = false

			end

		end

		@carrera_detalle = CarreraDetalle.where('carrera_id = ?', params[:carrera_id])
		#CALCULAR POSICIONES FINALES
		@carrera_detalle.each do |cd|

			carrera_tiempo_posicion_max = VCarreraTiempo.where('piloto_id = ? and carrera_id = ?', cd.piloto_id, cd.carrera_id).first
			cd.posicion = carrera_tiempo_posicion_max.posicion
			cd.save

			#CREAR PUNTAJE DETALLE
			puntaje_carrera_detalle = PuntajeCarreraDetalle.new
			puntaje_carrera_detalle.puntaje_carrera_id = puntaje_carrera.id
			
			puntaje_carrera_detalle.piloto_id = cd.piloto_id

			#obtener puntaje a favor
			puntaje_favor = PosicionPuntaje.where('posicion = ?', cd.posicion.to_i).first
			
			if puntaje_favor.present?

				puntaje_carrera_detalle.puntaje_favor = puntaje_favor.puntaje.to_i

			else

				puntaje_carrera_detalle.puntaje_favor = 1

			end
			#objetener puntaje en contra
			puntaje_contra = CarreraPenalizar.where('carrera_id = ? and piloto_id = ?',params[:carrera_id], cd.piloto_id).sum(:cantidad_puntos)
			
			if puntaje_contra.present?

				puntaje_carrera_detalle.puntaje_contra = puntaje_contra
			
			else

				puntaje_carrera_detalle.puntaje_contra = 0

			end

			puntaje_carrera_detalle.puntaje_total = puntaje_favor.puntaje - puntaje_contra

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
 				#finalizamos la inscripcion
 				inscripcion = Inscripcion.where('id = ?',@carrera.inscripcion_id).first
			    inscripcion.estado_inscripcion_id = PARAMETRO[:estado_inscripcion_finalizado]
			    inscripcion.save

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

	def puntaje_carrera

    	@puntajes_carrera = VPuntajeCarreraDetalle.orden_posicion.where("carrera_id = ?", params[:carrera_id]).paginate(per_page: 50, page: params[:page])
    	@carrera = Carrera.where('id = ?', params[:carrera_id]).first

    	@resumen_puntaje = VResumenPuntajeCarrera.where('carrera_id = ?', params[:carrera_id])

	    respond_to do |f|

	      f.js

	    end
    
  	end

  	def generar_resumen_puntaje

  		posicion = 1
  		generado_ok = false
  		@puntajes_carrera = VPuntajeCarreraDetalle.orden_puntaje.where("carrera_id = ?", params[:carrera_id])
		@puntajes_carrera.each do |pc|
			 
			
			@resumen_puntaje = ResumenPuntajeCarrera.new
			@resumen_puntaje.carrera_id = params[:carrera_id]
			@resumen_puntaje.piloto_id = pc.piloto_id
			@resumen_puntaje.posicion = posicion
			@resumen_puntaje.puntaje = pc.puntaje_total
			posicion = posicion + 1

			if @resumen_puntaje.save

				@generado_ok = true

			end


		end  		

  		respond_to do |f|

	      f.js

	    end

  	end
  
end
	    