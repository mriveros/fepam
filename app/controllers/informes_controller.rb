class InformesController < ApplicationController

	before_filter :require_usuario

  def indexa

  	cond = []
    args = []

  	@informe = "informes"
  	@msg = "" 
    
    if params[:piloto_id].present?

      cond << "piloto_id = ?"
      args << params[:piloto_id]

    end


    if params[:form_buscar_produccion][:estado_produccion_id].present?

      cond << "estado_produccion_id = ?"
      args << params[:form_buscar_produccion][:estado_produccion_id]

    end


    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0
     
      @resumen_carreras_detalles =  VResumenPuntajeCarrera.where(cond).orden_01.paginate(per_page: 10, page: params[:page])

    else

      @resumen_carreras_detalles = VResumenPuntajeCarrera.orden_01.paginate(per_page: 10, page: params[:page])
     
    end

    @parametros = { format: :pdf, carrera_id: @resumen_carreras_detalles.map(&:carrera_id), piloto_id: params[:piloto_id], campeonato_id: params[:campeonato_id], fecha_id: params[:fecha_id], fecha_desde: params[:fecha_desde], fecha_hasta: params[:fecha_hasta] }

    respond_to do |f|

      f.js

    end

  end

  def generar_pdf
    
    
   @resumen_carreras_detalles =  VResumenPuntajeCarrera.where("produccion_id in (?)", params[:produccion_id]).orden_01.paginate(per_page: 10, page: params[:page])
    

    respond_to do |f|
     
      f.pdf do

          render  :pdf => "planilla_resumen_carrera_#{Time.now.strftime("%Y_%m_%d__%H_%M")}",
                  :template => 'informes/planilla_resumen_carreras.pdf.erb',
                  :layout => 'pdf.html',
                  :header => {:html => { :template => "informes/cabecera_planilla_resumen_carreras.pdf.erb" ,
                  :locals   => { :resumen_carreras => @resumen_carreras_detalles }}},
                  :margin => {:top => 65,                         # default 10 (mm)
                  :bottom => 11,
                  :left => 3,
                  :right => 3},
                  :orientation => 'Landscape',
                  :page_size => "A4",
                  :footer => { :html => {:template => 'layouts/footer.pdf' },
                  :spacing => 1,
                  :line => true }
      end
      
    end

  end

end


