class InscripcionesController < ApplicationController

	before_filter :require_usuario

	  def index

	  end

	  def lista

	    cond = []
	    args = []

	    if params[:form_buscar_inscripciones_id].present?

	      cond << "id = ?"
	      args << params[:form_buscar_inscripciones_id]

	    end

	    if params[:form_buscar_inscripciones_descripcion].present?

	      cond << "descripcion ilike ?"
	      args << "%#{params[:form_buscar_inscripciones_descripcion]}%"

	    end

	    if params[:form_buscar_inscripciones_cantidad_fechas].present?

	      cond << "cantidad_fechas = ?"
	      args << params[:form_buscar_inscripciones_cantidad_fechas]

	    end

	    if params[:form_buscar_inscripciones_fecha].present?

	      cond << "fecha = ?"
	      args << params[:form_buscar_inscripciones_fecha]

	    end

	    

	    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

	    if cond.size > 0

	      @inscripciones =  Inscripcion.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
	      @total_encontrados = Inscripcion.where(cond).count

	    else

	      @inscripciones = Inscripcion.orden_01.paginate(per_page: 10, page: params[:page])
	      @total_encontrados = Inscripcion.count

	    end

	    @total_registros = Inscripcion.count

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

	    @inscripcion = Inscripcion.new()

	    @inscripcion.descripcion = params[:inscripcion][:descripcion].upcase
	  	@inscripcion.cantidad_fechas = params[:inscripcion][:cantidad_fechas]
	  	@inscripcion.fecha = params[:inscripcion][:fecha]
	    
	      if @inscripcion.save

	        auditoria_nueva("registrar inscripcion", "inscripciones", @inscripcion)
	       
	        @inscripcion_ok = true
	       

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

    @inscripciones_detalles = InscripcionDetalle.where("inscripcion_id = ?", params[:inscripcion_id]).paginate(per_page: 10, page: params[:page])
   
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

    unless params[:inscripcion_detalle][:descripcion].present?

      @valido = false
      @msg += " Debe Completar el campo descripción. \n"

    end

    unless params[:inscripcion_detalle][:fecha].present?

      @valido = false
      @msg += " Debe agregar una fecha. \n"

    end

    

    if @valido
      
      @inscripcion_detalle = InscripcionDetalle.new()
      @inscripcion_detalle.descripcion = params[:inscripcion_detalle][:descripcion].upcase
      @inscripcion_detalle.fecha = params[:inscripcion_detalle][:fecha]
      @inscripcion_detalle.inscripcion_id = params[:inscripcion_id]

        if @inscripcion_detalle.save

          auditoria_nueva("registrar inscripcion asignado a hacienda", "inscripciones", @inscripcion_detalle)
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

    @inscripcion_detalle = InscripcionDetalle.find(params[:inscripcion_id])

    if @valido

      if @inscripcion_detalle.destroy

        auditoria_nueva("eliminar fecha del campeonato", "inscripciones", @inscripcion_detalle)

        @eliminado = true

      else

        @msg = "ERROR: No se ha podido eliminar el inscripcion del campeonato porque ya cuenta con registros"

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