# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20220406034614) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accesos", force: true do |t|
    t.integer  "rol_id",     null: false
    t.integer  "accion_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "accesos", ["accion_id"], name: "accesos_accion_id_idx", using: :btree
  add_index "accesos", ["rol_id", "accion_id"], name: "accesos_uniq_01", unique: true, using: :btree
  add_index "accesos", ["rol_id"], name: "accesos_rol_id_idx", using: :btree

  create_table "acciones", force: true do |t|
    t.string   "descripcion",    null: false
    t.integer  "controlador_id", null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "acciones", ["controlador_id", "descripcion"], name: "acciones_uniq_01", unique: true, using: :btree
  add_index "acciones", ["controlador_id"], name: "acciones_controlador_id_idx", using: :btree
  add_index "acciones", ["descripcion"], name: "acciones_descripcion_idx", using: :btree

  create_table "carreras", force: true do |t|
    t.integer  "inscripcion_id",                      null: false
    t.datetime "fecha",             default: "now()"
    t.integer  "estado_carrera_id",                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carreras_detalles", force: true do |t|
    t.integer  "carrera_id",               null: false
    t.integer  "piloto_id",                null: false
    t.decimal  "posicion",   default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carreras_penalizaciones", force: true do |t|
    t.integer  "piloto_id",          null: false
    t.integer  "carrera_detalle_id", null: false
    t.integer  "carrera_id",         null: false
    t.time     "tiempo",             null: false
    t.decimal  "cantidad_puntos",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carreras_tiempos", force: true do |t|
    t.time     "tiempo",                           null: false
    t.decimal  "cantidad_vueltas",                 null: false
    t.integer  "piloto_id",                        null: false
    t.integer  "carrera_detalle_id",               null: false
    t.decimal  "posicion",           default: 0.0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "carrera_id",                       null: false
  end

  create_table "categorias", force: true do |t|
    t.string   "descripcion", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categorias", ["descripcion"], name: "categorias_descripcion_key", unique: true, using: :btree

  create_table "clientes", force: true do |t|
    t.string   "razon_social"
    t.string   "cliente_nombre"
    t.string   "cliente_apellido"
    t.string   "direccion"
    t.string   "telefono",         limit: 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "controladores", force: true do |t|
    t.string   "descripcion", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "controladores", ["descripcion"], name: "controladores_descripcion_idx", using: :btree
  add_index "controladores", ["descripcion"], name: "uniq_controladores_01", unique: true, using: :btree

  create_table "departamentos", force: true do |t|
    t.string   "descripcion",                                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pais_id",                                       null: false
    t.boolean  "estado",                         default: true, null: false
    t.integer  "division_politica_id"
    t.string   "codigo_departamento",  limit: 4,                null: false
    t.integer  "orden"
  end

  add_index "departamentos", ["codigo_departamento"], name: "departamentos_codigo_key", unique: true, using: :btree
  add_index "departamentos", ["descripcion"], name: "departamentos_descripcion_idx", using: :btree
  add_index "departamentos", ["descripcion"], name: "departamentos_descripcion_key", unique: true, using: :btree
  add_index "departamentos", ["pais_id"], name: "departamentos_pais_id_idx", using: :btree

  create_table "dias", force: true do |t|
    t.string "dia", limit: 30, null: false
  end

  add_index "dias", ["dia"], name: "dias_dia_key", unique: true, using: :btree

  create_table "disciplinas", force: true do |t|
    t.string   "descripcion",                    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "codigo_sigmec",       limit: 50
    t.integer  "codigo_nautilus"
    t.string   "descripcion_guarani"
    t.integer  "codigo_nautilus2"
  end

  add_index "disciplinas", ["descripcion"], name: "disciplinas_descripcion_key", unique: true, using: :btree

  create_table "divisiones_politicas", force: true do |t|
    t.string   "descripcion",                null: false
    t.boolean  "estado",      default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "divisiones_politicas", ["descripcion"], name: "divisiones_politicas_descripcion_idx", using: :btree
  add_index "divisiones_politicas", ["descripcion"], name: "divisiones_politicas_descripcion_key", unique: true, using: :btree

  create_table "documentos_fepam", force: true do |t|
    t.string   "numero",             limit: 100,                null: false
    t.string   "descripcion",                                   null: false
    t.date     "fecha_emision",                                 null: false
    t.integer  "tipo_resolucion_id",                            null: false
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.datetime "data_updated_at"
    t.boolean  "habilitado",                     default: true, null: false
    t.integer  "eleccion_id",                                   null: false
  end

  create_table "elecciones", id: false, force: true do |t|
    t.integer   "id",                        null: false
    t.string    "descripcion",               null: false
    t.timestamp "created_at",  precision: 0
    t.timestamp "updated_at",  precision: 0
  end

  add_index "elecciones", ["descripcion"], name: "elecciones_un", unique: true, using: :btree

  create_table "estados_carreras", force: true do |t|
    t.string    "descripcion",               null: false
    t.timestamp "created_at",  precision: 0
    t.timestamp "updated_at",  precision: 0
  end

  create_table "estados_civiles", force: true do |t|
    t.string   "descripcion", limit: 100, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "estados_civiles", ["descripcion"], name: "estados_civiles_descripcion_idx", using: :btree
  add_index "estados_civiles", ["descripcion"], name: "estados_civiles_descripcion_key", unique: true, using: :btree

  create_table "estados_inscripciones", force: true do |t|
    t.string    "descripcion",               null: false
    t.timestamp "created_at",  precision: 0
    t.timestamp "updated_at",  precision: 0
  end

  create_table "estados_inscripciones_detalles", force: true do |t|
    t.string    "descripcion",               null: false
    t.timestamp "created_at",  precision: 0
    t.timestamp "updated_at",  precision: 0
  end

  create_table "estados_torneos", force: true do |t|
    t.string    "descripcion",               null: false
    t.timestamp "created_at",  precision: 0
    t.timestamp "updated_at",  precision: 0
  end

  create_table "estados_torneos_detalles", force: true do |t|
    t.string    "descripcion",               null: false
    t.timestamp "created_at",  precision: 0
    t.timestamp "updated_at",  precision: 0
  end

  create_table "generos", force: true do |t|
    t.integer  "codigo",      null: false
    t.string   "descripcion", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "generos", ["codigo"], name: "generos_codigo_idx", using: :btree
  add_index "generos", ["codigo"], name: "generos_codigo_key", unique: true, using: :btree
  add_index "generos", ["descripcion"], name: "generos_descripcion_idx", using: :btree
  add_index "generos", ["descripcion"], name: "generos_descripcion_key", unique: true, using: :btree

  create_table "grupos_sanguineos", force: true do |t|
    t.text "descripcion"
  end

  add_index "grupos_sanguineos", ["descripcion"], name: "nombre_grupo_sanguineo_unique", unique: true, using: :btree

  create_table "informaciones", force: true do |t|
    t.string   "titulo",                limit: 100,                    null: false
    t.string   "contenido",             limit: 1000,                   null: false
    t.date     "fecha_publicacion",                                    null: false
    t.date     "fecha_fin_publicacion"
    t.integer  "usuario_id",                                           null: false
    t.datetime "created_at",                         default: "now()", null: false
    t.datetime "updated_at"
  end

  add_index "informaciones", ["contenido"], name: "ix_informaciones_001", using: :btree
  add_index "informaciones", ["usuario_id"], name: "ix_informaciones_002", using: :btree

  create_table "informaciones_enlaces", force: true do |t|
    t.string   "titulo",         limit: 100,                   null: false
    t.string   "enlace",                                       null: false
    t.integer  "informacion_id",                               null: false
    t.datetime "created_at",                 default: "now()", null: false
    t.datetime "updated_at"
  end

  add_index "informaciones_enlaces", ["enlace"], name: "ix_informaciones_enlaces_001", using: :btree
  add_index "informaciones_enlaces", ["informacion_id"], name: "ix_informaciones_enlaces_002", using: :btree

  create_table "informaciones_roles", force: true do |t|
    t.integer  "informacion_id",                   null: false
    t.integer  "rol_id",                           null: false
    t.datetime "created_at",     default: "now()", null: false
    t.datetime "updated_at"
  end

  add_index "informaciones_roles", ["informacion_id", "rol_id"], name: "uq_informaciones_roles_001", using: :btree
  add_index "informaciones_roles", ["informacion_id"], name: "ix_informaciones_roles_001", using: :btree
  add_index "informaciones_roles", ["rol_id"], name: "ix_informaciones_roles_002", using: :btree

  create_table "inscripciones", force: true do |t|
    t.integer   "torneo_detalle_id",                   null: false
    t.timestamp "fecha",                 precision: 0, null: false
    t.timestamp "created_at",            precision: 0
    t.timestamp "updated_at",            precision: 0
    t.integer   "estado_inscripcion_id",               null: false
    t.integer   "categoria_id",                        null: false
    t.integer   "torneo_id",                           null: false
  end

  create_table "inscripciones_detalles", force: true do |t|
    t.integer   "piloto_id",                                                               null: false
    t.timestamp "created_at",                              precision: 0
    t.timestamp "updated_at",                              precision: 0
    t.timestamp "fecha_inscripcion",                       precision: 0, default: "now()", null: false
    t.integer   "precio_id",                                                               null: false
    t.integer   "estado_inscripcion_detalle_id",                                           null: false
    t.integer   "inscripcion_id",                                                          null: false
    t.string    "numero",                        limit: 5,                                 null: false
  end

  create_table "jurisdicciones", force: true do |t|
    t.integer "departamento_id"
    t.string  "descripcion",                              null: false
    t.string  "address"
    t.float   "latitude"
    t.float   "longitude"
    t.boolean "gmaps"
    t.boolean "estado",                    default: true
    t.string  "codigo_distrito", limit: 4
  end

  add_index "jurisdicciones", ["departamento_id"], name: "jurisdicciones_departamento_id_idx", using: :btree
  add_index "jurisdicciones", ["descripcion"], name: "jurisdicciones_descripcion_idx", using: :btree

  create_table "localidades", force: true do |t|
    t.string    "descripcion",                               null: false
    t.integer   "jurisdiccion_id",                           null: false
    t.timestamp "created_at",                  precision: 0
    t.datetime  "updated_at"
    t.string    "codigo",          limit: nil
  end

  add_index "localidades", ["descripcion"], name: "localidades_descripcion_idx", using: :btree
  add_index "localidades", ["jurisdiccion_id"], name: "localidades_jurisdiccion_id_idx", using: :btree

  create_table "meses", force: true do |t|
    t.integer  "mes",         null: false
    t.string   "descripcion", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "meses", ["descripcion"], name: "meses_descripcion_key", unique: true, using: :btree
  add_index "meses", ["mes"], name: "meses_mes_key", unique: true, using: :btree

  create_table "nacionalidades", force: true do |t|
    t.integer  "codigo"
    t.string   "pais",        limit: 100, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "descripcion", limit: nil
  end

  add_index "nacionalidades", ["codigo"], name: "nacionalidades_codigo_key", unique: true, using: :btree
  add_index "nacionalidades", ["descripcion"], name: "nacionalidades_descripcion_key1", unique: true, using: :btree
  add_index "nacionalidades", ["pais"], name: "nacionalidades_descripcion_key", unique: true, using: :btree

  create_table "paises", force: true do |t|
    t.string   "descripcion", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "codigo",      null: false
  end

  add_index "paises", ["codigo"], name: "paises_codigo_key", unique: true, using: :btree
  add_index "paises", ["descripcion"], name: "paises_descripcion_key", unique: true, using: :btree

  create_table "perfiles", force: true do |t|
    t.integer  "usuario_id", null: false
    t.integer  "rol_id",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "perfiles", ["rol_id", "usuario_id"], name: "uniq_perfiles_01", unique: true, using: :btree

  create_table "personas", force: true do |t|
    t.string   "documento_persona",          limit: 50
    t.string   "nombre_persona",             limit: 100, null: false
    t.string   "apellido_persona",           limit: 100, null: false
    t.integer  "tipo_documento_id",                      null: false
    t.integer  "genero_id",                              null: false
    t.date     "fecha_nacimiento",                       null: false
    t.integer  "nacionalidad_id"
    t.string   "numero_oficina",             limit: 10
    t.date     "fecha_inscripcion"
    t.string   "folio",                      limit: 10
    t.string   "libro",                      limit: 10
    t.string   "acta",                       limit: 10
    t.string   "direccion",                  limit: 200
    t.integer  "jurisdiccion_id"
    t.integer  "localidad_id"
    t.integer  "numero_casa"
    t.string   "nombre_edificio",            limit: 100
    t.string   "numero_apartamento",         limit: 10
    t.string   "telefono",                   limit: 30
    t.string   "celular",                    limit: 30
    t.string   "correo_electronico",         limit: 50
    t.string   "carnet_indigena",            limit: 100
    t.integer  "estado_civil_id"
    t.integer  "comunidad_indigena_id"
    t.integer  "etnia_id"
    t.integer  "grupo_sanguineo_id"
    t.string   "lugar_nacimiento",           limit: 150
    t.string   "nacionalidad",               limit: nil
    t.string   "estado_civil",               limit: nil
    t.integer  "jurisdiccion_nacimiento_id"
    t.string   "barrio_localidad",           limit: 250
    t.string   "comunidad_indigena",         limit: 250
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "personas", ["apellido_persona"], name: "personas_apellido_persona_idx", using: :btree
  add_index "personas", ["documento_persona", "tipo_documento_id", "nacionalidad_id"], name: "uniq_personas_01", unique: true, using: :btree
  add_index "personas", ["documento_persona"], name: "personas_documento_persona_idx", using: :btree
  add_index "personas", ["id"], name: "personas_id_idx", using: :btree
  add_index "personas", ["nombre_persona", "apellido_persona", "fecha_nacimiento", "folio", "libro", "acta"], name: "uniq_personas_02", unique: true, using: :btree
  add_index "personas", ["nombre_persona"], name: "personas_nombre_persona_idx", using: :btree
  add_index "personas", ["tipo_documento_id"], name: "personas_tipo_documento_id_idx", using: :btree

  create_table "pilotos", force: true do |t|
    t.string    "nombres",                                      null: false
    t.string    "apellidos",                                    null: false
    t.string    "ci",                 limit: 10,                null: false
    t.integer   "grupo_sanguineo_id"
    t.timestamp "fecha_nacimiento",               precision: 0, null: false
    t.timestamp "created_at",                     precision: 0
    t.timestamp "updated_at",                     precision: 0
    t.string    "direccion",          limit: 510
    t.string    "telefono",           limit: 12
    t.string    "avatar_url",         limit: 300
    t.string    "photo",              limit: nil
  end

  create_table "posiciones_puntajes", force: true do |t|
    t.decimal  "posicion",   null: false
    t.decimal  "puntaje",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "precios", force: true do |t|
    t.string    "descripcion",                         null: false
    t.decimal   "monto",       precision: 6, scale: 0, null: false
    t.timestamp "created_at",  precision: 0
    t.timestamp "updated_at",  precision: 0
  end

  create_table "puntajes_carreras", force: true do |t|
    t.integer  "carrera_id", null: false
    t.datetime "fecha",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "puntajes_carreras_detalles", force: true do |t|
    t.integer  "puntaje_carrera_id", null: false
    t.integer  "piloto_id",          null: false
    t.decimal  "puntaje_favor",      null: false
    t.decimal  "puntaje_contra"
    t.decimal  "puntaje_total",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "registros_votos", force: true do |t|
    t.integer   "votante_id",                                   null: false
    t.timestamp "fecha_registro", precision: 0,                 null: false
    t.integer   "usuario_id",                                   null: false
    t.integer   "eleccion_id",                                  null: false
    t.timestamp "created_at",     precision: 0
    t.timestamp "updated_at",     precision: 0
    t.boolean   "voto_candidato",               default: false
  end

  create_table "roles", force: true do |t|
    t.string    "descripcion", limit: 100,                           null: false
    t.timestamp "created_at",              precision: 0
    t.timestamp "updated_at",              precision: 0
    t.integer   "sistema_id",                            default: 1
  end

  add_index "roles", ["descripcion"], name: "roles_descripcion_key", unique: true, using: :btree

  create_table "seccionales", id: false, force: true do |t|
    t.integer   "id",                        null: false
    t.string    "descripcion"
    t.timestamp "created_at",  precision: 0
    t.timestamp "updated_at",  precision: 0
  end

  create_table "selecciones_votos", id: false, force: true do |t|
    t.integer   "id",                        null: false
    t.string    "descripcion",               null: false
    t.timestamp "created_at",  precision: 0
    t.timestamp "updated_at",  precision: 0
  end

  create_table "sistemas", force: true do |t|
    t.string   "descripcion", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sistemas", ["descripcion"], name: "sistemas_descripcion_key", unique: true, using: :btree

  create_table "tipos_documentos", force: true do |t|
    t.integer  "codigo"
    t.string   "descripcion", limit: 100, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tipos_documentos", ["codigo"], name: "tipos_documentos_codigo_key", unique: true, using: :btree
  add_index "tipos_documentos", ["descripcion"], name: "tipos_documentos_descripcion_key", unique: true, using: :btree

  create_table "tipos_resoluciones_documentos", id: false, force: true do |t|
    t.integer  "id",          null: false
    t.string   "descripcion", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tipos_resoluciones_documentos", ["descripcion"], name: "tipos_resoluciones_descripcion_key", unique: true, using: :btree

  create_table "torneos", force: true do |t|
    t.string   "descripcion",      null: false
    t.decimal  "cantidad_fechas",  null: false
    t.date     "fecha",            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "estado_torneo_id", null: false
  end

  add_index "torneos", ["descripcion"], name: "torneos_dia_key", unique: true, using: :btree

  create_table "torneos_detalles", force: true do |t|
    t.string    "descripcion",                            null: false
    t.timestamp "fecha",                    precision: 0, null: false
    t.timestamp "created_at",               precision: 0
    t.timestamp "updated_at",               precision: 0
    t.integer   "torneo_id",                              null: false
    t.integer   "estado_torneo_detalle_id",               null: false
  end

  create_table "usuarios", force: true do |t|
    t.integer  "persona_id",                                      null: false
    t.string   "login",                                           null: false
    t.string   "crypted_password",                                null: false
    t.string   "password_salt",                                   null: false
    t.string   "email"
    t.boolean  "active",                          default: false
    t.string   "persistence_token",                               null: false
    t.string   "single_access_token",                             null: false
    t.string   "perishable_token",                                null: false
    t.integer  "login_count",                     default: 0,     null: false
    t.integer  "failed_login_count",              default: 0,     null: false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "token",               limit: nil
    t.integer  "perfil_actual_id"
  end

  add_index "usuarios", ["persona_id"], name: "usuarios_idx", using: :btree

  create_table "votantes", force: true do |t|
    t.integer "seccional_id"
    t.integer "numero_local"
    t.string  "cedula",           limit: 25
    t.string  "apellidos"
    t.string  "nombres"
    t.string  "direccion"
    t.string  "partido"
    t.string  "fecha_nacimiento"
    t.string  "fecha_afiliacion"
    t.integer "departamento_id"
  end

end
