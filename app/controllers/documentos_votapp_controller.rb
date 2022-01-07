class DocumentosVotappController < ApplicationController

  protect_from_forgery with: :null_session
  before_filter :require_usuario

  def index
  end

  def lista

    cond = []
    args = []

    if params[:form_buscar_documentos_votapp_id].present?

      cond << "documento_votapp_id = ?"
      args << params[:form_buscar_documentos_votapp_id]

    end

    if params[:form_buscar_documentos_votapp_numero].present?

      cond << "numero = ?"
      args << params[:form_buscar_documentos_votapp_numero]

    end
 
    if params[:form_buscar_documentos_votapp_descripcion].present?

      cond << "descripcion ilike ?"
      args << "%#{params[:form_buscar_documentos_votapp_descripcion]}%"

    end

    if params[:form_buscar_documentos_votapp_fecha_emision].present?

      cond << "fecha_emision = ?"
      args << params[:form_buscar_documentos_votapp_fecha_emision]

    end

    if params[:form_buscar_documentos_votapp][:tipo_resolucion_id].present?

      cond << "tipo_resolucion_id = ?"
      args << params[:form_buscar_documentos_votapp][:tipo_resolucion_id]

    end

    if params[:form_buscar_documentos_votapp][:eleccion_id].present?

      cond << "eleccion_id = ?"
      args << params[:form_buscar_documentos_votapp][:eleccion_id]

    end


    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0
 
      @documentos_votapp =  VDocumentoVotapp.orden_id.where(cond).paginate(per_page: 12, page: params[:page])
      @total_encontrados = VDocumentoVotapp.where(cond).count

    else

      @documentos_votapp = VDocumentoVotapp.orden_id.paginate(per_page: 12, page: params[:page])
      @total_encontrados = VDocumentoVotapp.count

    end

    @total_registros = VDocumentoVotapp.count

    respond_to do |f|

      f.js

    end

  end

  def agregar_archivo

    @documento_votapp = DocumentoVotapp.new

    @ultimo_registro = DocumentoVotapp.last

    if @ultimo_registro.present?

      @nuevo_incremento = @ultimo_registro.numero.to_i + 1

    else

      @nuevo_incremento = 1

    end

    respond_to do |f|

      f.js

    end

  end


  def guardar_archivo_adjunto

    @valido = true
    @msg = ""

    if @valido

      DocumentoVotapp.transaction do 

        @documento_votapp = DocumentoVotapp.new
        @documento_votapp.numero = params[:numero]
        @documento_votapp.descripcion = params[:descripcion]
        @documento_votapp.fecha_emision = params[:fecha_emision]
        @documento_votapp.tipo_resolucion_id = PARAMETRO[:resolucion]
        @documento_votapp.eleccion_id = params[:documento_votapp][:eleccion_id]
        @documento_votapp.data = params[:data]

        if @documento_votapp.save

          auditoria_nueva("agregar documento nuevo en votapp", "documentos_votapp", @documento_votapp)
          @guardado_ok = true

        end

      end #end transaction

    end

    rescue Exception => exc  
     
      if exc.present?        
          
        @excep = exc.message.split(':')    
        @msg = @excep
       
      end

    
    respond_to do |f|

      f.js

    end

  end
  

  def agregar_archivo_operador

    @documento_votapp = DocumentoVotapp.new

    @ultimo_registro = DocumentoVotapp.last

    if @ultimo_registro.present?

      @nuevo_incremento = @ultimo_registro.numero.to_i + 1

    else

      @nuevo_incremento = 1

    end

    respond_to do |f|

      f.js

    end

  end


  def guardar_archivo_operador

    @valido = true
    @msg = ""

    if @valido

      DocumentoVotapp.transaction do 

        @documento_votapp = DocumentoVotapp.new
        @documento_votapp.numero = params[:numero]
        @documento_votapp.descripcion = params[:descripcion]
        @documento_votapp.fecha_emision = params[:fecha_emision]
        @documento_votapp.tipo_resolucion_id = PARAMETRO[:resolucion]
        @documento_votapp.eleccion_id = params[:documento_votapp][:eleccion_id]
        @documento_votapp.data = params[:data]

        if @documento_votapp.save

          auditoria_nueva("agregar documento nuevo en votapp", "documentos_votapp", @documento_votapp)
          @guardado_ok = true

        end

      end #end transaction

    end

    rescue Exception => exc  
     
      if exc.present?        
          
        @excep = exc.message.split(':')    
        @msg = @excep
       
      end

    
    respond_to do |f|

      f.js

    end

  end

  

  def editar_archivo

    @documentos_votapp = DocumentoVotapp.find(params[:id])

    respond_to do |f|

      f.js

    end

  end

  def actualizar_archivo_adjunto

    @valido = true
    @msg = ""

    if @valido

      DocumentoVotapp.transaction do 

        @documento_votapp = DocumentoVotapp.new
        @documento_votapp.numero = params[:numero]
        @documento_votapp.descripcion = params[:descripcion]
        @documento_votapp.fecha_emision = params[:fecha_emision]
        @documento_votapp.tipo_resolucion_id = PARAMETRO[:resolucion]
        @documento_votapp.eleccion_id = params[:documento_votapp][:eleccion_id]
        @documento_votapp.data = params[:data]

        if @documento_votapp.save

          auditoria_nueva("agregar documento nuevo en votapp", "documentos_votapp", @documento_votapp)
          @guardado_ok = true

        end

      end #end transaction

    end

    rescue Exception => exc  
     
      if exc.present?        
          
        @excep = exc.message.split(':')    
        @msg = @excep
       
      end

    
    respond_to do |f|

      f.js

    end

  end

  def eliminar_archivo

    valido = true
    @msg = ""

    @documento_votapp = DocumentoVotapp.find(params[:id])

    @documento_votapp_elim = @documento_votapp

    if valido

      if @documento_votapp.destroy

        auditoria_nueva("eliminar documento votapp", "documentos_votapp", @documento_votapp_elim)

        @eliminado = true

      else

        @msg = "ERROR: No se ha podido eliminar el documento. Intente más tarde."

      end

    end
    

    respond_to do |f|

      f.js

    end

  end


  def buscar_estado_ganado

     @documentos_votapp = DocumentoVotapp.where("descripcion ilike ?", "%#{params[:descripcion]}%")

    respond_to do |f|

      f.html
      f.json { render :json => @documentos_votapp }

    end

  end

  


end