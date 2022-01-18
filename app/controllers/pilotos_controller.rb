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

    if params[:form_buscar_pilotos_ruc].present?

      cond << "pilotos.ruc_ci = ?"
      args << params[:form_buscar_pilotos_ruc]

    end

    if params[:form_buscar_pilotos_nombre].present?

      cond << "pilotos.nombres ilike ?"
      args << "%#{params[:form_buscar_pilotos_nombre]}%"

    end

    if params[:form_buscar_pilotos_apellido].present?

      cond << "pilotos.apellidos ilike ?"
      args << "%#{params[:form_buscar_pilotos_apellido]}%"

    end

    if params[:form_buscar_pilotos_direccion].present?

      cond << "pilotos.direccion ilike ?"
      args << "%#{params[:form_buscar_pilotos_direccion]}%"

    end

    if params[:form_buscar_pilotos_telefono].present?

      cond << "pilotos.telefono ilike ?"
      args << "%#{params[:form_buscar_pilotos_telefono]}%"

    end

    if params[:form_buscar_pilotos_observacion].present?

      cond << "pilotos.observacion ilike ?"
      args << "%#{params[:form_buscar_pilotos_observacion]}%"

    end

    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @pilotos =  piloto.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = piloto.where(cond).count
      
    else

      @pilotos = piloto.orden_01.paginate(per_page: 10, page: params[:page])
      @total_encontrados = piloto.count

    end

    @total_registros = piloto.count

  	respond_to do |f|
	    
	   f.js
	    
	  end

  end

  def agregar

    @piloto = piloto.new

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
      
      @piloto = piloto.new()
      @piloto.nombre_razon_social = params[:piloto][:nombre_razon_social].upcase
      @piloto.ruc_ci = params[:piloto][:ruc_ci]
      @piloto.direccion = params[:piloto][:direccion].upcase
      @piloto.telefono = params[:piloto][:telefono]
      @piloto.observacion = params[:piloto][:observacion]

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
    
    @piloto = piloto.find(params[:id])

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

    @piloto = piloto.find(params[:piloto_id])

    auditoria_id = auditoria_antes("actualizar piloto", "pilotos", @piloto)

    if valido

      @piloto.nombre_razon_social = params[:piloto][:nombre_razon_social].upcase
      @piloto.ruc_ci = params[:piloto][:ruc_ci]
      @piloto.direccion = params[:piloto][:direccion].upcase
      @piloto.telefono = params[:piloto][:telefono]
      @piloto.observacion = params[:piloto][:observacion]

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
    
    @personas = piloto.where("piloto_nombre ilike ?", "%#{params[:piloto_produccion]}%")

    respond_to do |f|
      
      f.html
      f.json { render :json => @personas }
    
    end
    
  end

  def eliminar

    valido = true
    @msg = ""

    @piloto = piloto.find(params[:id])

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