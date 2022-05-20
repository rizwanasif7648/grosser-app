# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Permission.where(name: 'Customers', status: 1, icon: 'icon-customer', path: '/customers').first_or_create!
Permission.where(name: 'Products', status: 1, icon: 'icon-product', path: '/products').first_or_create!
Permission.where(name: 'Roles & Permissions', status: 1, icon: 'icon-role', path: '/roles_permissions').first_or_create!
Permission.where(name: 'Create Incident', status: 1, icon: 'fa fa-plus-circle', path: '/incidents/new').first_or_create!
Permission.where(name: 'Boxes', status: 1, icon: 'icon-box', path: '/boxes').first_or_create!
Permission.where(name: 'LogBook', status: 1, icon: 'icon-log_book', path: '/logbooks').first_or_create!
Permission.where(name: 'Users', status: 1, icon: 'icon-user', path: '/users').first_or_create!
Permission.where(name: 'Reports', status: 1, icon: 'icon-reports', path: '/reports').first_or_create!
Permission.where(name: 'Settings', status: 1, icon: 'icon-settings', path: '/settings').first_or_create!
Permission.where(name: 'Requisition', status: 1, icon: 'icon-settings', path: '/replenishments').first_or_create!
Permission.where(name: 'Requisition LogBook', status: 1, icon: 'icon-settings', path: '/replenishments/logbook').first_or_create!
Permission.where(name: 'Adjustment', status: 1, icon: 'fas fa-sliders-h', path: '/adjustments').first_or_create!

first_indus_lookup = Lookup.where(category: 'industry', key: 'Health Care', value: 'health_care').first_or_create!
Lookup.where(category: 'industry', key: 'Accounting', value: 'accounting').first_or_create!
Lookup.where(category: 'industry', key: 'Information Technology', value: 'it').first_or_create!
Lookup.where(category: 'industry', key: 'Food Chain', value: 'food_chain').first_or_create!
Lookup.where(category: 'industry', key: 'Media', value: 'media').first_or_create!

first_customer = Customer.where(name: "3whealthcare", url: "http://www.3whealthcare.ca/", email: "admin@3whealthcare.com", phone: "+16475744757", street_address: "755 Queensway E #5, Mississauga, ON L4Y 4C5.", country: "Canada", state: "Ontario", city: "Apple Hill", postcode: "A1A 1A1", status: "active", industry: first_indus_lookup.value).first_or_create!
first_role =  Role.where(title: 'Admin', customer_id: first_customer.id).first_or_create
first_role.role_permissions.update_all(is_readable: true, is_createable: true, is_updateable: true, is_deleteable: true)
@user = User.find_by_email('admin@3whealthcare.com')
first_user = User.new({name: 'Super Admin', email: 'admin@3whealthcare.com', phone: "+16475744757", role_id: first_role.id, customer_id: first_customer.id})
first_user.save!(validate: false) if !@user

Lookup.where(category: 'category', key: 'Accounting', value: 'accounting').first_or_create!
Lookup.where(category: 'category', key: 'Information Technology', value: 'it').first_or_create!
Lookup.where(category: 'category', key: 'Food Chain', value: 'food_chain').first_or_create!
Lookup.where(category: 'category', key: 'Media', value: 'media').first_or_create!

Lookup.where(category: 'brand', key: 'Nestle', value: 'nestle').first_or_create!
Lookup.where(category: 'brand', key: 'Dettol', value: 'dettol').first_or_create!
Lookup.where(category: 'brand', key: 'Clustox', value: 'clustox').first_or_create!
Lookup.where(category: 'brand', key: 'Dell', value: 'dell').first_or_create!

Lookup.where(category: 'asset_type', key: 'Medicine', value: 'medicine').first_or_create!
Lookup.where(category: 'asset_type', key: 'Tablets', value: 'tablets').first_or_create!
Lookup.where(category: 'asset_type', key: 'Injections', value: 'injections').first_or_create!
Lookup.where(category: 'asset_type', key: 'Cotton', value: 'cotton').first_or_create!

Lookup.where(category: 'box_type', key: 'Scissor', value: 'scissor').first_or_create!
Lookup.where(category: 'box_type', key: 'Bandage', value: 'bandage').first_or_create!
AdminUser.create!(email: 'superadmin@3whealthcare.com', password: 'password', password_confirmation: 'password') if Rails.env.development?