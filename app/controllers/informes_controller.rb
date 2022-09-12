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

    if params[:form_buscar_resumen][:torneo_id].present?
      
      cond << "torneo_id = ?"
      args << params[:form_buscar_resumen][:torneo_id]

    end

    if params[:form_buscar_resumen][:torneo_detalle_id].present?

      cond << "torneo_detalle_id = ?"
      args << params[:form_buscar_resumen][:torneo_detalle_id]

    end

    if params[:form_buscar_resumen][:categoria_id].present?

      cond << "categoria_id = ?"
      args << params[:form_buscar_resumen][:categoria_id]

    end

    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0
        
      @resumen_puntaje_carreras =  VResumenPuntajeCarrera.where(cond).orden_01

    else

      @resumen_puntaje_carreras = VResumenPuntajeCarrera.orden_01.paginate(per_page: 10, page: params[:page])
     
    end

    @parametros = { format: :pdf, piloto_id: params[:piloto_id], torneo_id: params[:form_buscar_resumen][:torneo_id], torneo_detalle_id: params[:form_buscar_resumen][:torneo_detalle_id], categoria_id: params[:form_buscar_resumen][:categoria_id]}

    respond_to do |f|

      f.js

    end

  end

  def generar_pdf
    
    
    cond = []
    args = []
    if params[:torneo_id].present?

        cond << "torneo_id = ?"
      args << params[:torneo_id]

    end

    if params[:torneo_detalle_id].present?

      cond << "torneo_detalle_id = ?"
      args << params[:torneo_detalle_id]

    end

    if params[:categoria_id].present?

      cond << "categoria_id = ?"
      args << params[:categoria_id]

    end

    if params[:piloto_id].present?

      cond << "piloto_id = ?"
      args << params[:piloto_id]

    end

    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0
      
      @resumen_puntaje_carreras =  VResumenPuntajeCarrera.where(cond).orden_01

    else

      @resumen_puntaje_carreras = VResumenPuntajeCarrera.orden_01.paginate(per_page: 25, page: params[:page])
     
    end
    

    respond_to do |f|
     
      f.pdf do

          render  :pdf => "planilla_resumen_carrera_#{Time.now.strftime("%Y_%m_%d__%H_%M")}",
                  :template => 'informes/planilla_resumen_carreras.pdf.erb',
                  :layout => 'pdf.html',
                  :header => {:html => { :template => "informes/cabecera_planilla_resumen_carreras.pdf.erb" ,
                  :locals   => { :resumen_carreras => @resumen_puntaje_carreras, :torneo_id => params[:torneo_id] }}},
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


