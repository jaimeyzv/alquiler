class Estacionamiento < ActiveRecord::Base
    self.table_name = "Estacionamiento"
    belongs_to :distrito
end