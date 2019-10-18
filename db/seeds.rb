# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

City.create(name: "Patna")
City.create(name: "Ranchi")
City.create(name: "Delhi")
City.create(name: "Kolkata")
City.create(name: "Jaipur")
City.create(name: "Mumbai")

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

KilometerRange.create(name: "Upto 10000 km")
KilometerRange.create(name: "10000-20000 km")
KilometerRange.create(name: "20000-40000 km")
KilometerRange.create(name: "40000-60000 km")

Year.create(start: 2000, end: 2019)

Condition.create(condition: "Fair", cost: "₹ 1,26,532 - ₹ 1,37,697")
Condition.create(condition: "Good", cost: "₹1,35,464 - ₹ 1,60,026")
Condition.create(condition: "Very Good", cost: "₹ 1,57,793 - ₹ 1,68,958")
Condition.create(condition: "Excellent", cost: "₹ 1,66,725 - ₹ 1,71,191")

#admin user
User.create(name: "Admin", email: "administrator@mail.com", password: "administrator", password_confirmation: "administrator", activated: true, activated_at: Time.now, number: "9547276700", category: "Admin", admin: true)

#seller and buyer
User.create( name: "Seller1", email: "seller1@mail.com", password: "password", password_confirmation: "password", activated: true, activated_at: Time.now, number: "9547276700", category: "Seller")
User.create( name: "Seller2", email: "seller2@mail.com", password: "password", password_confirmation: "password", activated: true, activated_at: Time.now, number: "9547276700", category: "Seller")
User.create( name: "Buyer1", email: "buyer1@mail.com", password: "password", password_confirmation: "password", activated: true, activated_at: Time.now, number: "9547276700", category: "Buyer")
User.create( name: "Buyer2", email: "buyer2@mail.com", password: "password", password_confirmation: "password", activated: true, activated_at: Time.now, number: "9547276700", category: "Buyer")



Car.__elasticsearch__.create_index!(force: true)
