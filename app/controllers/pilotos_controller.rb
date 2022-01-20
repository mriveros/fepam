class PilotosController < ApplicationController

before_filter :require_usuario
skip_before_action :verify_authenticity_token

  def index
   

  end

  def lista

    cond = []
    args = []

    if params[:form_buscar_pilotos_id].present?

      cond << "pilotos.id = ?"
      args << params[:form_buscar_pilotos_id]

    end

    if params[:form_buscar_pilotos_nombre].present?

      cond << "pilotos.nombres ilike ?"
      args << "%#{params[:form_buscar_pilotos_nombre]}%"

    end

    if params[:form_buscar_pilotos_apellido].present?

      cond << "pilotos.apellidos ilike ?"
      args << "%#{params[:form_buscar_pilotos_apellido]}%"

    end

    if params[:form_buscar_pilotos_ci].present?

      cond << "pilotos.ci = ?"
      args << "%#{params[:form_buscar_pilotos_ci]}%"

    end

    if params[:form_buscar_pilotos_fecha_nacimiento].present?

      cond << "pilotos.ci = ?"
      args << params[:form_buscar_pilotos_fecha_nacimiento]

    end

    if params[:form_buscar_pilotos_grupo_sanguineo].present?

      cond << "pilotos.grupo_sanguineo ilike ?"
      args << "%#{params[:form_buscar_pilotos_grupo_sanguineo]}%"

    end

    if params[:form_buscar_pilotos_direccion].present?

      cond << "pilotos.direccion ilike ?"
      args << "%#{params[:form_buscar_pilotos_direccion]}%"

    end

    if params[:form_buscar_pilotos_telefono].present?

      cond << "pilotos.telefono ilike ?"
      args << "%#{params[:form_buscar_pilotos_telefono]}%"

    end

    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @pilotos =  Piloto.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = Piloto.where(cond).count
      
    else

      @pilotos = Piloto.orden_01.paginate(per_page: 10, page: params[:page])
      @total_encontrados = Piloto.count

    end

    @total_registros = Piloto.count

  	respond_to do |f|
	    
	   f.js
	    
	  end

  end

  def agregar

    @piloto = Piloto.new

    respond_to do |f|
	    
	      f.js
	    
	  end

  end

  def guardar

    @valido = true
    @msg = ""
    @guardado_ok = false

    unless params[:piloto][:nombre_razon_social].present?

      @valido = false
      @msg += " Debe Completar el campo Nombre o Razón Social. \n"

    end

    unless params[:piloto][:ruc_ci].present?

      @valido = false
      @msg += "Debe Completar el campo con el RUC o CI. \n"

    end

    

    if @valido
      
      @piloto = Piloto.new()
      @piloto.nombres = params[:piloto][:nombres].upcase
      @piloto.apellidos = params[:piloto][:apellidos].upcase
      @piloto.ci = params[:piloto][:ci]
      @piloto.grupo_sanguineo = params[:piloto][:grupo_sanguineo].upcase
      @piloto.fecha_nacimiento = params[:piloto][:fecha_nacimiento]
      @piloto.direccion = params[:piloto][:direccion].upcase
      @piloto.telefono = params[:piloto][:telefono]
      

        if @piloto.save

          auditoria_nueva("registrar piloto", "pilotos", @piloto)
         
          @guardado_ok = true
         
        end 

    end
  
    rescue Exception => exc  
    # dispone el mensaje de error 
    #puts "Aqui si muestra el error ".concat(exc.message)
      if exc.present?        
        @excep = exc.message.split(':')    
        @msg = @excep[3].concat(" "+@excep[4].to_s)
      
      end                
              
  	respond_to do |f|
	    
	      f.js
	    
	end

  end

  def editar
    
    @piloto = Piloto.find(params[:id])

  	respond_to do |f|
	    
	      f.js
	    
	end

  end

  def actualizar

    valido = true
    @msg = ""

    unless params[:piloto][:nombre_razon_social].present?

      @valido = false
      @msg += " Debe Completar el campo Nombre o Razón Social. \n"

    end

    unless params[:piloto][:ruc_ci].present?

      @valido = false
      @msg += "Debe Completar el campo con el RUC o CI. \n"

    end

    @piloto = Piloto.find(params[:piloto_id])

    auditoria_id = auditoria_antes("actualizar piloto", "pilotos", @piloto)

    if valido

      @piloto.nombres = params[:piloto][:nombres].upcase
      @piloto.apellidos = params[:piloto][:apellidos].upcase
      @piloto.ci = params[:piloto][:ci]
      @piloto.grupo_sanguineo = params[:piloto][:grupo_sanguineo].upcase
      @piloto.fecha_nacimiento = params[:piloto][:fecha_nacimiento]
      @piloto.direccion = params[:piloto][:direccion].upcase
      @piloto.telefono = params[:piloto][:telefono]

      if @piloto.save

        auditoria_despues(@piloto, auditoria_id)
        @piloto_ok = true

      end

    end
        rescue Exception => exc  
        # dispone el mensaje de error 
        #puts "Aqui si muestra el error ".concat(exc.message)
        if exc.present?        
        @excep = exc.message.split(':')    
        @msg = @excep[3].concat(" "+@excep[4])
        end                

  	respond_to do |f|
	    
	      f.js
	    
	  end

  end

  def buscar_piloto
    
    @pilotos = Piloto.where("nombre ilike ?", "%#{params[:piloto]}%")

    respond_to do |f|
      
      f.html
      f.json { render :json => @personas }
    
    end
    
  end

  def buscar_persona
    
    if params[:tipo_documento_id].present? && params[:nacionalidad_id] && params[:ci].present?

      @persona = Persona.where("tipo_documento_id = ? and nacionalidad_id = ? and documento_persona = ?", params[:tipo_documento_id], params[:nacionalidad_id], params[:ci])  

    end

    respond_to do |f|
      f.json { render :json => @persona.first}
    end

  end

  def eliminar

    valido = true
    @msg = ""

    @piloto = Piloto.find(params[:id])

    @piloto_elim = @piloto  

    if valido

      if @piloto.destroy

        auditoria_nueva("eliminar piloto", "pilotos", @piloto_elim)

        @eliminado = true

      else

        @msg = "ERROR: No se ha podido eliminar el piloto."

      end

    end
        rescue Exception => exc  
        # dispone el mensaje de error 
        #puts "Aqui si muestra el error ".concat(exc.message)
        if exc.present?        
        @excep = exc.message.split(':')    
        @msg = @excep[3].concat(" "+@excep[4])
        @eliminado = false
        end
        
    respond_to do |f|

      f.js

    end

  end

end