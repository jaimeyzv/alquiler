class Estacionamiento < ActiveRecord::Base
    self.table_name = "Estacionamiento"
    has_many :estacionamientocomentarios
end