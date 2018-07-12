class Distrito < ActiveRecord::Base
    self.table_name = "Distrito"
    has_many :estacionamientos
end