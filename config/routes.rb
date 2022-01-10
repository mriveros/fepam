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


#-------------------------BLOQUE TAREAS AUTOMATICAS------------------------
#CRONTAB
get 'crontab_ultron/index'
#--------------------------------------------------------------------------


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
  get 'documentos_FEPAM/index'
  post 'documentos_FEPAM/lista'
  get 'documentos_FEPAM/lista'
  get 'documentos_FEPAM/agregar_archivo'
  post 'documentos_FEPAM/guardar_archivo_adjunto'
  get 'documentos_FEPAM/editar_archivo'
  post 'documentos_FEPAM/actualizar_archivo_adjunto'
  get 'documentos_FEPAM/eliminar_archivo'
  get 'documentos_FEPAM/agregar_archivo_operador'
  post 'documentos_FEPAM/guardar_archivo_operador'


#INFO COMPRAS
  get 'info_compras/index'
  post 'info_compras/lista'
  get 'info_compras/lista'
  get 'info_compras/exportar_pdf'
  post 'info_compras/exportar_pdf'

#CARGOS
  post 'cargos/lista'
  get 'cargos/lista'
  get 'cargos/agregar'
  post 'cargos/guardar'
  get 'cargos/eliminar'
  get 'cargos/editar'
  post 'cargos/actualizar'
  get 'cargos/index'

  #HACIENDAS
  get 'haciendas/index'
  post 'haciendas/lista'
  get 'haciendas/lista'
  get 'haciendas/agregar'
  post 'haciendas/guardar'
  get 'haciendas/editar'
  post 'haciendas/actualizar'
  get 'haciendas/eliminar'
  get 'haciendas/buscar_jurisdiccion'
  get 'haciendas/haciendas_detalles'
  get 'haciendas/agregar_hacienda_detalle'
  post 'haciendas/guardar_hacienda_detalle'
  get 'haciendas/eliminar_hacienda_detalle'
  get 'haciendas/obtener_potreros'

  #POTREROS
  get 'potreros/index'
  post 'potreros/lista'
  get 'potreros/lista'
  get 'potreros/agregar'
  post 'potreros/guardar'
  get 'potreros/editar'
  post 'potreros/actualizar'
  get 'potreros/eliminar'
  get 'potreros/potrero_detalle'
  get 'potreros/agregar_potrero_detalle'
  post 'potreros/guardar_potrero_detalle'
  get 'potreros/eliminar_potrero_detalle'


  #ESTADOS GANADOS
  get 'estados_ganados/index'
  post 'estados_ganados/lista'
  get 'estados_ganados/lista'
  get 'estados_ganados/agregar'
  post 'estados_ganados/guardar'
  get 'estados_ganados/editar'
  post 'estados_ganados/actualizar'
  get 'estados_ganados/eliminar'
  get 'estados_ganados/buscar_estado_ganado'

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


   #INFORMACIONES
  get 'informaciones/index'
  get 'informaciones/lista'
  post 'informaciones/lista'
  get 'informaciones/perfiles'
  get 'informaciones/enlaces'
  get 'informaciones/agregar'
  post 'informaciones/guardar'
  get 'informaciones/agregar_enlace'
  get 'informaciones/guardar_enlace'
  post 'informaciones/guardar_enlace'
  get 'informaciones/agregar_perfil'
  get 'informaciones/guardar_perfil'
  get 'informaciones/eliminar'
  get 'informaciones/editar'
  post 'informaciones/actualizar'
  get 'informaciones/editar_enlace'
  post 'informaciones/actualizar_enlace'
  get 'informaciones/eliminar_enlace'
  get 'informaciones/eliminar_rol'

  #DETALLES DEBITOS
  post 'detalles_debitos/lista'
  get 'detalles_debitos/lista'
  get 'detalles_debitos/agregar'
  post 'detalles_debitos/guardar'
  get 'detalles_debitos/eliminar'
  get 'detalles_debitos/editar'
  post 'detalles_debitos/actualizar'
  get 'detalles_debitos/index'

  #DETALLES CREDITOS
  post 'detalles_creditos/lista'
  get 'detalles_creditos/lista'
  get 'detalles_creditos/agregar'
  post 'detalles_creditos/guardar'
  get 'detalles_creditos/eliminar'
  get 'detalles_creditos/editar'
  post 'detalles_creditos/actualizar'
  get 'detalles_creditos/index'


  #CLIENTES
  post 'clientes/lista'
  get 'clientes/lista'
  get 'clientes/agregar'
  post 'clientes/guardar'
  get 'clientes/eliminar'
  get 'clientes/editar'
  post 'clientes/actualizar'
  get 'clientes/index'
  get 'clientes/buscar_cliente'

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
