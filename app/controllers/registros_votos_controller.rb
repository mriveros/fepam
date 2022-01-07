class RegistrosVotosController < ApplicationController

	before_filter :require_usuario

	  def index

	  end

	  def lista

	    cond = []
	    args = []

	    if params[:form_buscar_registros_votos_id].present?

	      cond << "registro_voto_id = ?"
	      args << params[:form_buscar_registros_votos_id]

	    end

	    if params[:form_buscar_registros_votos_fecha_registro].present?

	      cond << "fecha_registro = ?"
	      args << params[:form_buscar_registros_votos_fecha_registro]

	    end

	    if params[:form_buscar_registros_votos][:eleccion_id].present?

	      cond << "eleccion_id = ?"
	      args << "#{params[:form_buscar_registros_votos][:eleccion_id]}"

	    end

	    if params[:form_buscar_registros_votos_cedula].present?

	      cond << "cedula = ?"
	      args << params[:form_buscar_registros_votos_cedula]

	    end

	    if params[:form_buscar_registros_votos_nombre].present?

	    	cond << "nombres ilike ?"
      		args << "%#{params[:form_buscar_registros_votos_nombre]}%"

	    end

	    if params[:form_buscar_registros_votos_apellido].present?

	    	cond << "apellidos ilike ?"
      		args << "%#{params[:form_buscar_registros_votos_apellido]}%"

	    end

	    if params[:form_buscar_registros_votos_partido].present?

	    	cond << "partido ilike ?"
      		args << "%#{params[:form_buscar_registros_votos_partido]}%"

	    end

	    if params[:form_buscar_registros_votos][:seccional_id].present?

	      cond << "seccional_id = ?"
	      args << "#{params[:form_buscar_registros_votos][:seccional_id]}"

	    end

	    if params[:form_buscar_registros_votos][:departamento_id].present?

	      cond << "departamento_id = ?"
	      args << "#{params[:form_buscar_registros_votos][:departamento_id]}"

	    end

	    if params[:form_buscar_registros_votos_usuario_insercion].present?

	    	cond << "usuario_insercion ilike ?"
      		args << "%#{params[:form_buscar_registros_votos_usuario_insercion]}%"

	    end

	    if params[:form_buscar_registros_votos][:voto_candidato_id].present?

	    	if params[:form_buscar_registros_votos][:voto_candidato_id].to_i == 1
	      	
	      		cond << "voto_candidato = ?"
	      		args << true

	      	else

	      		cond << "voto_candidato = ?"
	      		args << false

	      	end

	    end
	    

	    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

	    if cond.size > 0

	      @registros_votos =  VRegistroVoto.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
	      @total_encontrados = VRegistroVoto.where(cond).count

	    else

	      @registros_votos = VRegistroVoto.orden_01.paginate(per_page: 10, page: params[:page])
	      @total_encontrados = VRegistroVoto.count

	    end

	    @total_registros = VRegistroVoto.count

	    respond_to do |f|

	      f.js

	    end

	  end


	  def agregar

	    @registro_voto = RegistroVoto.new

	    respond_to do |f|

	      f.js

	    end

	  end

	  def agregar_voto_operador

	    @registro_voto = RegistroVoto.new

	    respond_to do |f|

	      f.js

	    end

	  end


	  def guardar

	    valido = true
	    @msg = ""

	    @registro_voto = RegistroVoto.where("votante_id = ? and eleccion_id = ?",params[:votante_id], params[:registro_voto][:eleccion_id]).first
	   	if @registro_voto.present?

	   		valido = false
	   		@msg = "Este voto ya fue registrado."

	   	end 

	    if valido

		    @registro_voto = RegistroVoto.new()
		    @registro_voto.votante_id = params[:votante_id]
		    @registro_voto.fecha_registro = Date.today
		    @registro_voto.usuario_id = current_usuario.id
		    @registro_voto.eleccion_id = params[:registro_voto][:eleccion_id]
		    
		    
		      if @registro_voto.save

		        auditoria_nueva("registrar voto", "registros_votos", @registro_voto)
		       
		        @registro_voto_ok = true
		       

		      end

		end          
	               
	    respond_to do |f|

	      f.js

	    end

	  end

	  def guardar_voto_operador

	    valido = true
	    @msg = ""

	    @registro_voto = RegistroVoto.where("votante_id = ? and eleccion_id = ?",params[:votante_id], params[:registro_voto][:eleccion_id]).first
	   	if @registro_voto.present?

	   		valido = false
	   		@msg = "Este voto ya fue registrado."

	   	end 

	    if valido

		    @registro_voto = RegistroVoto.new()
		    @registro_voto.votante_id = params[:votante_id]
		    @registro_voto.fecha_registro = Date.today
		    @registro_voto.usuario_id = current_usuario.id
		    @registro_voto.eleccion_id = params[:registro_voto][:eleccion_id]
		    
		    
		      if @registro_voto.save

		        auditoria_nueva("registrar voto", "registros_votos", @registro_voto)
		       
		        @registro_voto_ok = true
		       

		      end

		end          
	               
	    respond_to do |f|

	      f.js

	    end

	  end


	  def eliminar

	    valido = true
	    @msg = ""

	    @registro_voto = RegistroVoto.find(params[:id])
		@registro_voto_elim = @registro_voto

	    if valido

	      	if @registro_voto.destroy

		        auditoria_nueva("eliminar registro_voto", "registros_votos", @registro_voto)
		        @eliminado = true

	    	end

		end

	    respond_to do |f|

	      f.js

	    end

	  end


	  def marcar_voto_candidato

	    valido = true
	    @msg = ""

	    @registro_voto = RegistroVoto.find(params[:id])
		@registro_voto.voto_candidato = true

	  	if @registro_voto.save

	        auditoria_nueva("marcar registro de voto", "registros_votos", @registro_voto)
	        @marcado = true

	    end

	    respond_to do |f|

	      f.js

	    end

	  end

	  def desmarcar_voto_candidato

	    valido = true
	    @msg = ""

	    @registro_voto = RegistroVoto.find(params[:id])
		@registro_voto.voto_candidato = false

	  	if @registro_voto.save

	        auditoria_nueva("desmarcar registro de voto", "registros_votos", @registro_voto)
	        @desmarcado = true

	    end

	    respond_to do |f|

	      f.js

	    end

	  end

	  
	    

end