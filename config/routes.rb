Rails.application.routes.draw do


  namespace 'api' do
    namespace 'v1' do

      resources :personas
      resources :usuarios

    end
  end


  
  #WEB SERVICES 
  namespace :api, defaults: { format: "json" } do
  
    namespace :v1 do
  
      resources :web_service_user
      post '/api/v1/web_service_user/index'


      resources :web_service_hacienda
      get '/api/v1/web_service_hacienda/index'

      resources :web_service_potrero
      get '/api/v1/web_service_potrero/index'


    end
  
  end

# Avatar routes
get "avatar/:size/:background/:text" => Dragonfly.app.endpoint { |params, app|
  app.generate(:initial_avatar, URI.unescape(params[:text]), { size: params[:size], background_color: params[:background] })
}, as: :avatar

#-------------------------BLOQUE TAREAS AUTOMATICAS------------------------
#CRONTAB
get 'crontab_ultron/index'
#--------------------------------------------------------------------------

#INFORMES
get "informes/index"
get "informes/indexa"
get "informes/generar_pdf"

#CARRERAS
  post 'carreras/lista'
  get 'carreras/lista'
  get 'carreras/agregar'
  post 'carreras/guardar'
  get 'carreras/eliminar'
  get 'carreras/editar'
  post 'carreras/actualizar'
  get 'carreras/index'
  get 'carreras/carrera_detalle'
  get 'carreras/marcar_tiempo'
  get 'carreras/penalizar_piloto'
  get 'carreras/finalizar_carrera'
  get 'carreras/puntaje_carrera'
  get 'carreras/generar_resumen_puntaje'


#INSCRIPCIONES
  post 'inscripciones/lista'
  get 'inscripciones/lista'
  get 'inscripciones/agregar'
  post 'inscripciones/guardar'
  get 'inscripciones/eliminar'
  get 'inscripciones/editar'
  post 'inscripciones/actualizar'
  get 'inscripciones/index'
  get 'inscripciones/inscripcion_detalle'
  get 'inscripciones/agregar_inscripcion_detalle'
  post 'inscripciones/guardar_inscripcion_detalle'
  get 'inscripciones/editar_inscripcion_detalle'
  post 'inscripciones/actualizar_inscripcion_detalle'
  get 'inscripciones/eliminar_inscripcion_detalle'
  get 'inscripciones/buscar_inscripcion'
  
  
#TORNEOS
  post 'torneos/lista'
  get 'torneos/lista'
  get 'torneos/agregar'
  post 'torneos/guardar'
  get 'torneos/eliminar'
  get 'torneos/editar'
  post 'torneos/actualizar'
  get 'torneos/index'
  get 'torneos/torneo_detalle'
  get 'torneos/agregar_torneo_detalle'
  post 'torneos/guardar_torneo_detalle'
  get 'torneos/editar_torneo_detalle'
  post 'torneos/actualizar_torneo_detalle'
  get 'torneos/eliminar_torneo_detalle'
  get 'torneos/buscar_torneo_detalle'
  get 'torneos/finalizar_campeonato'
  get 'torneos/resumen_campeonato'

  #PILOTOS
  post 'pilotos/lista'
  get 'pilotos/lista'
  get 'pilotos/agregar'
  post 'pilotos/guardar'
  get 'pilotos/eliminar'
  get 'pilotos/editar'
  post 'pilotos/actualizar'
  get 'pilotos/index'
  get 'pilotos/buscar_piloto'
  get 'pilotos/buscar_persona'
  get 'pilotos/buscar_piloto_documento'

   #CATEGORIAS
  post 'categorias/lista'
  get 'categorias/lista'
  get 'categorias/agregar'
  post 'categorias/guardar'
  get 'categorias/eliminar'
  get 'categorias/editar'
  post 'categorias/actualizar'
  get 'categorias/index'
  get 'categorias/buscar_piloto'
  get 'categorias/buscar_persona'
  

#VOTANTES
  post 'votantes/lista'
  get 'votantes/lista'
  get 'votantes/agregar'
  post 'votantes/guardar'
  get 'votantes/eliminar'
  get 'votantes/editar'
  post 'votantes/actualizar'
  get 'votantes/index'
  get 'votantes/buscar_votante'

  #REGISTROS VOTOS
  post 'registros_votos/lista'
  get 'registros_votos/lista'
  get 'registros_votos/agregar'
  get 'registros_votos/agregar_voto_operador'
  post 'registros_votos/guardar'
  post 'registros_votos/guardar_voto_operador'
  get 'registros_votos/eliminar'
  get 'registros_votos/index'
  get 'registros_votos/marcar_voto_candidato'
  get 'registros_votos/desmarcar_voto_candidato'

  #DOCUMENTOS FEPAM
  get 'documentos_fepam/index'
  post 'documentos_fepam/lista'
  get 'documentos_fepam/lista'
  get 'documentos_fepam/agregar_archivo'
  post 'documentos_fepam/guardar_archivo_adjunto'
  get 'documentos_fepam/editar_archivo'
  post 'documentos_fepam/actualizar_archivo_adjunto'
  get 'documentos_fepam/eliminar_archivo'
  get 'documentos_fepam/agregar_archivo_operador'
  post 'documentos_fepam/guardar_archivo_operador'

  #EMPRESAS TRANSPORTES
  get 'empresas_transportes/index'
  post 'empresas_transportes/lista'
  get 'empresas_transportes/lista'
  get 'empresas_transportes/agregar'
  post 'empresas_transportes/guardar'
  get 'empresas_transportes/editar'
  post 'empresas_transportes/actualizar'
  get 'empresas_transportes/eliminar'
  get 'empresas_transportes/buscar_empresa_transporte'


#----------------------------FIN BLOQUE DE RUTAS URNAS----------------------------


#----------------------------INICIO EJEMPLOS----------------------------


  

  

  #JURISDICCIONES
  get 'jurisdicciones/index'
  get 'jurisdicciones/buscar_juridisccion_oferta'


#-----------------------INICIO BLOQUE DE RUTAS KERNEL DEL SISTEMA(NO TOCAR)---------------


  #PERSONAS
  post 'personas/lista'
  get 'personas/lista'
  get 'personas/agregar'
  get 'personas/agregar_persona_senatics'
  post 'personas/guardar'
  post 'personas/guardar_persona_senatics'
  get 'personas/eliminar'
  get 'personas/editar'
  post 'personas/actualizar'
  get 'personas/index'
  get 'personas/mostrar_formulario'
  post 'personas/unificar_persona'
  get 'personas/obtener_datos'
  get 'personas/buscar_persona_senatics'
  get 'personas/buscar_chofer'

  #ROLES
  post 'roles/lista'
  get 'roles/lista'
  get 'roles/agregar'
  post 'roles/guardar'
  get 'roles/eliminar'
  get 'roles/editar'
  post 'roles/actualizar'
  get 'roles/accesos'
  get 'roles/agregar_acceso'
  get 'roles/guardar_acceso'
  get 'roles/eliminar_acceso'
  get 'roles/index'

  #CONTROLADORES
  post 'controladores/lista'
  get 'controladores/lista'
  get 'controladores/agregar'
  post 'controladores/guardar'
  get 'controladores/eliminar'
  get 'controladores/editar'
  post 'controladores/actualizar'
  get 'controladores/acciones'
  get 'controladores/agregar_accion'
  post 'controladores/guardar_accion'
  get 'controladores/eliminar_accion'
  get 'controladores/index'

  #Usuarios
  get 'usuarios/cambiar_perfil_actual'
  get 'usuarios/mi_cuenta'
  post 'usuarios/actualizar_mi_cuenta'
  post 'usuarios/actualizar_mi_password'
  get 'usuarios/perfiles'
  get 'usuarios/agregar_perfil'
  get 'usuarios/guardar_perfil'
  get 'usuarios/eliminar_perfil'
  post 'usuarios/actualizar_password'
  get 'usuarios/reset_password'
  get 'usuarios/perfiles'
  get 'usuarios/index'
  get 'usuarios/lista'
  post 'usuarios/lista'
  get 'usuarios/agregar'
  post 'usuarios/guardar'
  get 'usuarios/eliminar'
  get 'usuarios/editar'
  post 'usuarios/actualizar'
  get 'usuarios/buscar_persona'
  post 'usuarios/cambiar_estado_usuario'

  #Login
  get 'login' => 'usuarios_sessions#new',      :as => :login
  get 'logout' => 'usuarios_sessions#destroy', :as => :logout
  post 'usuarios_sessions/create'
  get 'usuarios_sessions/acceso_denegado'
  get 'usuarios_sessions/new'
  get 'usuarios_sessions/mantenimiento'

  get 'principal/buscar_institucion'
  get 'principal/buscar_persona'
  get 'principal/buscar_usuario'
  post 'principal/guardar_recuperar_password'
  get 'principal/recuperar_password'
  post 'principal/guardar_usuario'
  get 'principal/activar_cuenta'
  get 'principal/agregar_usuario'
  get 'contactos' => 'principal#contactos', :as => :contactos
  get 'index' => 'principal#index', :as => :index
  get 'about' => 'principal#about', :as => :about
  get 'legal' => 'principal#legal', :as => :legal
  get 'index' => 'principal#index', :as => :indexv

  root 'principal#index'

  get 'application/autocompletar' => 'application#autocompletar', :as => :autocompletar

 #------------------------------------------------------------

end
