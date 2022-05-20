industries = ['Marine',
              'Royal Palaces/Villas',
              'Public Transport',
              'Government Institutions (Correctional Services) | Central Jail, Police Stations',
              'Government Institutions (Public Services) | Schools, Universities, Hospital, MOH, MOI, Municipality, Free Zones etc',
              'Commercial (Manufacturing) | Warehouses, Plants, Offices etc',
              'Commercial (Construction) | Residential apartments, Construction sites etc',
              'Commercial - Offices',
              'Commercial (Retail) | Hotels, Restaurants, Malls',
              'Healthcare (Clinics, Hospitals, Pharmacies)']

categories = ['Bandages',
              'Disposables',
              'First Aid',
              'Medical Equipment',
              'Medicines',
              'Patient Care',
              'Personal Care',
              'Plasters',
              'Protective Equipment',
              'Wound Care',
              'Other']

brands = ['3W',
          'AMEYA',
          'DERMAPORE',
          'DETTOL',
          'FIRSTAR (FS)',
          'KY',
          'PAK MARTIN',
          'POLAR BAG',
          'RYCOM',
          'SANIPLAST',
          'SUGAMA',
          'GENERIC']


box_types = ['3W-019 GREEN EMPTY BOX | ABS | MOUNTABLE',
             '3W-041 WHITE EMPTY BOX | PLASTIC',
             '3W-043 ORANGE/GREY EMPTY TACKLE BOX | PLASTIC',
             '3W-060 ORANGE EMPTY BOX | ABS | MOUNTABLE',
             '3W-060 WHITE EMPTY BOX | ABS | MOUNTABLE',
             '3W-061 WALL BRACKET EMPTY BOX | ABS | MOUNTABLE',
             '3W-062 ORANGE FAB XL EMPTY BOX | ABS| MOUNTABLE',
             '3W-065 BLUE SMALL EMPTY BOX | PLASTIC',
             '3W-067 WHITE EMPTY BOX | PLASTIC',
             '3W-072 PP EMPTY BOX | PLASTIC',
             '3W-073 ORANGE WATER/AIR TIGHT | ABS',
             '3W-075M WHITE METALLIC SMALL EMPTY BOX |MOUNTABLE',
             '3W-076B WHITE METALLIC LARGE EMPTY BOX | MOUNTABLE',
             '3W-094 EVA AUTOMOBILE KIT | SOFT MATERIAL',
             '3W-095BA FIRST RESPONDER BAG COMPLETE | SOFT MATERIAL',
             '3W-920 EMERGENCY BAG | SOFT MATERIAL',
             '3W-9330 S/S EMPTY BOX | STAINLESS STEEL | MOUNTABLE',
             '3W-9331 M/S EMPTY BOX | STAINLESS STEEL | MOUNTABLE',
             '3W-9332 L/S EMPTY BOX | STAINLESS STEEL | MOUNTABLE',
             '3W-9500 SHELF-STYLE EMPTY BOX | HIPS | MOUNTABLE',
             '3W-9704 EMPTY BOX | PLASTIC',
             '3W-9706 GREEN SMALL EMPTY | PLASTIC | MOUNTABLE',
             '3W-9707 GREEN LARGE EMPTY | PLASTIC | MOUNTABLE']

asset_types = ['Oral', 'Intravenous', 'Transdermal', 'Blood-brain barrier	', 'Inhalation', 'Topical Cream	']
# Lookup.all.destroy_all

industries.each do |industry|
  puts '****** -> '+ industry + '<- ******'
  Lookup.where(category: 'industry', key: industry, value: industry).first_or_create!
end

categories.each do |category|
  puts '****** -> '+ category + '<- ******'
  Lookup.where(category: 'category', key: category, value: category).first_or_create!
end

brands.each do |brand|
  puts '****** -> '+ brand + '<- ******'
  Lookup.where(category: 'brand', key: brand, value: brand).first_or_create!
end

box_types.each do |box_type|
  puts '****** -> '+ box_type + '<- ******'
  Lookup.where(category: 'box_type', key: box_type, value: box_type).first_or_create!
end

asset_types.each do |asset_type|
  puts '****** -> '+ asset_type + '<- ******'
  Lookup.where(category: 'asset_type', key: asset_type, value: asset_type).first_or_create!
end
