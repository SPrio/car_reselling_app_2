# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

City.create(name: 'Patna')
City.create(name: 'Ranchi')
City.create(name: 'Delhi')
City.create(name: 'Kolkata')
City.create(name: 'Jaipur')
City.create(name: 'Mumbai')

Brand.create(name: "BMW")
Brand.create(name: "Ferrari")
Brand.create(name: "Audi")
Brand.create(name: "Honda")
Brand.create(name: "Mahindra")
Brand.create(name: "Maruti Suzuki") 
Brand.create(name: "Tata")

Model.create( name: "Alto", brand_id: 6)
Model.create( name: "R8", brand_id: 3)
Model.create( name: "City", brand_id: 4)
Model.create( name: "Etron", brand_id: 1)
Model.create( name: "Indigo", brand_id: 7)
Model.create( name: "Swift", brand_id: 6)

Variant.create(name: "Petrol")
Variant.create(name: "Diesel")

State.create(name: "WB")
State.create(name: "BR")
State.create(name: "MH")
State.create(name: "DL")
