class VotantesController < ApplicationController

	before_filter :require_usuario

	  def index

	  end

	  def lista

	    cond = []
	    args = []

	    if params[:form_buscar_votantes_id].present?

	      cond << "votante_id = ?"
	      args << params[:form_buscar_votantes_id]

	    end

	    if params[:form_buscar_votantes_cedula].present?

	      cond << "cedula = ?"
	      args << params[:form_buscar_votantes_cedula]

	    end

	    if params[:form_buscar_votantes_nombre].present?

	    	cond << "nombres ilike ?"
      		args << "%#{params[:form_buscar_votantes_nombre]}%"

	    end

	    if params[:form_buscar_votantes_apellido].present?

	    	cond << "apellidos ilike ?"
      		args << "%#{params[:form_buscar_votantes_apellido]}%"

	    end

	    if params[:form_buscar_votantes_direccion].present?

	    	cond << "direccion ilike ?"
      		args << "%#{params[:form_buscar_votantes_direccion]}%"

	    end

	    if params[:form_buscar_votantes_partido].present?

	    	cond << "partido ilike ?"
      		args << "%#{params[:form_buscar_votantes_partido]}%"

	    end

	    if params[:form_buscar_votantes_fecha_nacimiento].present?

	    	cond << "fecha_nacimiento ilike ?"
      		args << "%#{params[:form_buscar_votantes_fecha_nacimiento]}%"

	    end

	    if params[:form_buscar_votantes_fecha_afiliacion].present?

	    	cond << "fecha_afiliacion ilike ?"
      		args << "%#{params[:form_buscar_votantes_fecha_afiliacion]}%"

	    end

	    if params[:form_buscar_votantes][:seccional_id].present?

	      cond << "seccional_id = ?"
	      args << "#{params[:form_buscar_votantes][:seccional_id]}"

	    end


	    if params[:form_buscar_votantes][:departamento_id].present?

	      cond << "departamento_id = ?"
	      args << "#{params[:form_buscar_votantes][:departamento_id]}"

	    end

	    

	    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

	    if cond.size > 0

	      @votantes =  VVotante.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
	      @total_encontrados = VVotante.where(cond).count

	    else

	      @votantes = VVotante.orden_01.paginate(per_page: 10, page: params[:page])
	      @total_encontrados = VVotante.count

	    end

	    @total_registros = VVotante.count

	    respond_to do |f|

	      f.js

	    end

	  end


	  def agregar

	    @votante = Votante.new

	    respond_to do |f|

	      f.js

	    end

	  end


	  def guardar

	    valido = true
	    @msg = ""

	    @votante = Votante.new()

	    @votante.descripcion = params[:votante][:descripcion].upcase
	    @votante.sueldo = params[:votante][:sueldo].to_s.gsub(/[$.]/,'').to_i
	    
	      if @votante.save

	        auditoria_nueva("registrar votante", "votantes", @votante)
	       
	        @votante_ok = true
	       

	      end              
	               
	    respond_to do |f|

	      f.js

	    end

	  end


	  def eliminar

	    valido = false
	    @msg = ""

	    @votante = Votante.find(params[:id])
		@votante_elim = @votante

	    if valido

	      	if @votante.destroy

		        auditoria_nueva("eliminar votante", "votantes", @votante)
		        @eliminado = true

	    	end
		end

	    respond_to do |f|

	      f.js

	    end

	  end

	  def editar

	    @votante = Votante.find(params[:id])

	    respond_to do |f|

	      f.js

	    end

	  end

	  def actualizar

	    valido = true
	    @msg = ""

	    @votante = Votante.where("id = ?", params[:votante][:id]).first
	    auditoria_id = auditoria_antes("actualizar votante", "votantes", @votante)

	    if valido

	      
	    	@votante.cedula = params[:votante][:cedula]
	    	@votante.nombres = params[:votante][:nombres].upcase
	    	@votante.apellidos = params[:votante][:apellidos].upcase
	    	@votante.direccion = params[:votante][:direccion].upcase
	    	@votante.partido = params[:votante][:partido].upcase
	    	@votante.seccional_id = params[:votante][:seccional_id]
	    	@votante.departamento_id = params[:votante][:departamento_id]
	      	
	      	if @votante.save

	      		auditoria_despues(@votante, auditoria_id)
	        	@votante_ok = true

	      end

	    end           
	        
	    respond_to do |f|

	      f.js

	    end

	  end


	 def buscar_votante
    
	    if  params[:cedula].present?

	      @votante = Votante.where("cedula = ?", params[:cedula])  
	 
	    end

	    respond_to do |f|

	      f.json { render :json => @votante.first}

	    end

  end
	    

end