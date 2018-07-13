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

ActiveRecord::Schema.define(version: 0) do

  create_table "distrito", primary_key: "IdDistrito", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "Nombre", limit: 100, null: false
  end

  create_table "estacionamiento", primary_key: "IdEstacionamiento", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "IdUsuario", null: false
    t.string "Nombre", limit: 100, null: false
    t.string "Direccion", limit: 150, null: false
    t.string "Latitud", limit: 20, null: false
    t.string "Longitud", limit: 20, null: false
    t.string "TelefonoFijo", limit: 20
    t.decimal "PrecioPorHora", precision: 10, scale: 2, null: false
    t.string "Foto", limit: 200, null: false
    t.integer "Dimensiones", null: false
    t.integer "IdTipoEstacionamiento", null: false
    t.integer "IdUbicacion", null: false
    t.datetime "FechaRegistro", null: false
    t.integer "IdDistrito", null: false
    t.index ["IdDistrito"], name: "fk_Estacionamiento_Distrito1_idx"
  end

  create_table "estacionamientoalquilerservicioadicional", primary_key: "IdEstacionamientoAlquilerServicioAdicional", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "IdServicioAdicional", null: false
    t.integer "AlquilerEstacionamiento_IdAlquilerEstacionamiento", null: false
    t.index ["AlquilerEstacionamiento_IdAlquilerEstacionamiento"], name: "fk_AlquilerEstacionamientoServicioAdicional_AlquilerEstacio_idx"
  end

  create_table "estacionamientocomentario", primary_key: ["IdEstacionamientoComentario", "EstacionamientoComentario_IdEstacionamientoComentario"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "IdEstacionamientoComentario", null: false, auto_increment: true
    t.integer "Puntuacion", null: false
    t.string "Comentario", limit: 100
    t.integer "IdComentarioPadre"
    t.datetime "FechaRegistro", null: false
    t.integer "IdEstacionamiento", null: false
    t.integer "IdUsuario", null: false
    t.integer "EstacionamientoComentario_IdEstacionamientoComentario", null: false
    t.index ["EstacionamientoComentario_IdEstacionamientoComentario"], name: "fk_EstacionamientoComentario_EstacionamientoComentario1_idx"
    t.index ["IdEstacionamiento"], name: "fk_EstacionamientoComentario_Estacionamiento1_idx"
    t.index ["IdUsuario"], name: "fk_EstacionamientoComentario_Usuario1_idx"
  end

  create_table "estacionamientoservicioadicional", primary_key: "IdEstacionamientoServicioAdicional", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "IdEstacionamiento", null: false
    t.integer "IdServicioAdicional", null: false
    t.decimal "tarifaAdicional", precision: 10, scale: 2
    t.index ["IdEstacionamiento"], name: "fk_EstacionamientoServicioAdicional_Estacionamiento1_idx"
    t.index ["IdServicioAdicional"], name: "fk_EstacionamientoServicioAdicional_ServicioAdicional1_idx"
  end

  create_table "estacionamientoxalquiler", primary_key: "IdEstacionamientoAlquiler", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "FechaInicio", null: false
    t.datetime "FechaFin", null: false
    t.decimal "PrecioTotal", precision: 10, scale: 2, null: false
    t.datetime "FechaRegistro", null: false
    t.integer "IdEstacionamiento", null: false
    t.integer "Usuario_IdUsuario", null: false
    t.index ["IdEstacionamiento"], name: "fk_AlquilerEstacionamiento_Estacionamiento1_idx"
    t.index ["Usuario_IdUsuario"], name: "fk_EstacionamientoxAlquiler_Usuario1_idx"
  end

  create_table "publicidad", primary_key: "IdPublicidad", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "Titulo", limit: 100, null: false
    t.string "Contenido", limit: 300, null: false
    t.datetime "FechaInicio", null: false
    t.datetime "FechaFin", null: false
    t.decimal "Tarifa", precision: 10, scale: 2, null: false
    t.string "UbicacionPagina", limit: 20, null: false
    t.datetime "FechaRegistro", null: false
  end

  create_table "servicioadicional", primary_key: "IdServicioAdicional", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "Descripcion", limit: 100, null: false
    t.datetime "FechaRegistro", null: false
    t.integer "Usuario_IdUsuario", null: false
    t.index ["Usuario_IdUsuario"], name: "fk_ServicioAdicional_Usuario1_idx"
  end

  create_table "tipodocumento", primary_key: "IdTipoDocumento", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "Nombre", limit: 50, null: false
  end

  create_table "tipoestacionamiento", primary_key: "IdTipoEstacionamiento", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "Nombre", limit: 50, null: false
  end

  create_table "usuario", primary_key: "IdUsuario", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "TipoUsuario", limit: 1, null: false
    t.string "Nombres", limit: 100, null: false
    t.string "ApellidoPaterno", limit: 100, null: false
    t.string "ApellidoMaterno", limit: 100, null: false
    t.string "Sexo", limit: 1, null: false
    t.string "Correo", limit: 100, null: false
    t.string "Contrasenia", limit: 10, null: false
    t.datetime "FechaNacimiento", null: false
    t.string "Celular", limit: 20, null: false
    t.datetime "FechaRegistro", null: false
    t.integer "TipoDocumento_IdTipoDocumento", null: false
    t.index ["TipoDocumento_IdTipoDocumento"], name: "fk_Duenio_TipoDocumento_idx"
  end

  add_foreign_key "estacionamiento", "distrito", column: "IdDistrito", primary_key: "iddistrito", name: "fk_Estacionamiento_Distrito1"
  add_foreign_key "estacionamientoalquilerservicioadicional", "estacionamientoxalquiler", column: "AlquilerEstacionamiento_IdAlquilerEstacionamiento", primary_key: "idestacionamientoalquiler", name: "fk_AlquilerEstacionamientoServicioAdicional_AlquilerEstaciona1"
  add_foreign_key "estacionamientocomentario", "estacionamiento", column: "IdEstacionamiento", primary_key: "idestacionamiento", name: "fk_EstacionamientoComentario_Estacionamiento1"
  add_foreign_key "estacionamientocomentario", "estacionamientocomentario", column: "EstacionamientoComentario_IdEstacionamientoComentario", primary_key: "idestacionamientocomentario", name: "fk_EstacionamientoComentario_EstacionamientoComentario1"
  add_foreign_key "estacionamientocomentario", "usuario", column: "IdUsuario", primary_key: "idusuario", name: "fk_EstacionamientoComentario_Usuario1"
  add_foreign_key "estacionamientoservicioadicional", "estacionamiento", column: "IdEstacionamiento", primary_key: "idestacionamiento", name: "fk_EstacionamientoServicioAdicional_Estacionamiento1"
  add_foreign_key "estacionamientoservicioadicional", "servicioadicional", column: "IdServicioAdicional", primary_key: "idservicioadicional", name: "fk_EstacionamientoServicioAdicional_ServicioAdicional1"
  add_foreign_key "estacionamientoxalquiler", "estacionamiento", column: "IdEstacionamiento", primary_key: "idestacionamiento", name: "fk_AlquilerEstacionamiento_Estacionamiento1"
  add_foreign_key "estacionamientoxalquiler", "usuario", column: "Usuario_IdUsuario", primary_key: "idusuario", name: "fk_EstacionamientoxAlquiler_Usuario1"
  add_foreign_key "servicioadicional", "usuario", column: "Usuario_IdUsuario", primary_key: "idusuario", name: "fk_ServicioAdicional_Usuario1"
  add_foreign_key "usuario", "tipodocumento", column: "TipoDocumento_IdTipoDocumento", primary_key: "idtipodocumento", name: "fk_Duenio_TipoDocumento"
end
