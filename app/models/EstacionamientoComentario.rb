class EstacionamientoComentario < ActiveRecord::Base
    self.table_name = "EstacionamientoComentario"
    belongs_to :estacionamiento
end