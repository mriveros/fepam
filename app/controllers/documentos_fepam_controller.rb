class DocumentosFepamController < ApplicationController

  protect_from_forgery with: :null_session
  before_filter :require_usuario

  def index
  end

  def lista

    cond = []
    args = []

    if params[:form_buscar_documentos_fepam_id].present?

      cond << "documento_fepam_id = ?"
      args << params[:form_buscar_documentos_fepam_id]

    end

    if params[:form_buscar_documentos_fepam_numero].present?

      cond << "numero = ?"
      args << params[:form_buscar_documentos_fepam_numero]

    end
 
    if params[:form_buscar_documentos_fepam_descripcion].present?

      cond << "descripcion ilike ?"
      args << "%#{params[:form_buscar_documentos_fepam_descripcion]}%"

    end

    if params[:form_buscar_documentos_fepam_fecha_emision].present?

      cond << "fecha_emision = ?"
      args << params[:form_buscar_documentos_fepam_fecha_emision]

    end

    if params[:form_buscar_documentos_fepam][:tipo_resolucion_id].present?

      cond << "tipo_resolucion_id = ?"
      args << params[:form_buscar_documentos_fepam][:tipo_resolucion_id]

    end

    if params[:form_buscar_documentos_fepam][:eleccion_id].present?

      cond << "eleccion_id = ?"
      args << params[:form_buscar_documentos_fepam][:eleccion_id]

    end


    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0
 
      @documentos_fepam =  VDocumentoFEPAM.orden_id.where(cond).paginate(per_page: 12, page: params[:page])
      @total_encontrados = VDocumentoFEPAM.where(cond).count

    else

      @documentos_fepam = VDocumentoFEPAM.orden_id.paginate(per_page: 12, page: params[:page])
      @total_encontrados = VDocumentoFEPAM.count

    end

    @total_registros = VDocumentoFEPAM.count

    respond_to do |f|

      f.js

    end

  end

  def agregar_archivo

    @documento_FEPAM = DocumentoFEPAM.new

    @ultimo_registro = DocumentoFEPAM.last

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

      DocumentoFEPAM.transaction do 

        @documento_FEPAM = DocumentoFEPAM.new
        @documento_FEPAM.numero = params[:numero]
        @documento_FEPAM.descripcion = params[:descripcion]
        @documento_FEPAM.fecha_emision = params[:fecha_emision]
        @documento_FEPAM.tipo_resolucion_id = PARAMETRO[:resolucion]
        @documento_FEPAM.eleccion_id = params[:documento_FEPAM][:eleccion_id]
        @documento_FEPAM.data = params[:data]

        if @documento_FEPAM.save

          auditoria_nueva("agregar documento nuevo en FEPAM", "documentos_fepam", @documento_FEPAM)
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

    @documento_FEPAM = DocumentoFEPAM.new

    @ultimo_registro = DocumentoFEPAM.last

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

      DocumentoFEPAM.transaction do 

        @documento_FEPAM = DocumentoFEPAM.new
        @documento_FEPAM.numero = params[:numero]
        @documento_FEPAM.descripcion = params[:descripcion]
        @documento_FEPAM.fecha_emision = params[:fecha_emision]
        @documento_FEPAM.tipo_resolucion_id = PARAMETRO[:resolucion]
        @documento_FEPAM.eleccion_id = params[:documento_FEPAM][:eleccion_id]
        @documento_FEPAM.data = params[:data]

        if @documento_FEPAM.save

          auditoria_nueva("agregar documento nuevo en FEPAM", "documentos_fepam", @documento_FEPAM)
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

    @documentos_fepam = DocumentoFEPAM.find(params[:id])

    respond_to do |f|

      f.js

    end

  end

  def actualizar_archivo_adjunto

    @valido = true
    @msg = ""

    if @valido

      DocumentoFEPAM.transaction do 

        @documento_FEPAM = DocumentoFEPAM.new
        @documento_FEPAM.numero = params[:numero]
        @documento_FEPAM.descripcion = params[:descripcion]
        @documento_FEPAM.fecha_emision = params[:fecha_emision]
        @documento_FEPAM.tipo_resolucion_id = PARAMETRO[:resolucion]
        @documento_FEPAM.eleccion_id = params[:documento_FEPAM][:eleccion_id]
        @documento_FEPAM.data = params[:data]

        if @documento_FEPAM.save

          auditoria_nueva("agregar documento nuevo en FEPAM", "documentos_fepam", @documento_FEPAM)
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

    @documento_FEPAM = DocumentoFEPAM.find(params[:id])

    @documento_FEPAM_elim = @documento_FEPAM

    if valido

      if @documento_FEPAM.destroy

        auditoria_nueva("eliminar documento FEPAM", "documentos_fepam", @documento_FEPAM_elim)

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

     @documentos_fepam = DocumentoFEPAM.where("descripcion ilike ?", "%#{params[:descripcion]}%")

    respond_to do |f|

      f.html
      f.json { render :json => @documentos_fepam }

    end

  end

  


end