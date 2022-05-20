Permission.where(name: 'Customers', status: 1, icon: 'icon-customer', path: '/customers').first_or_create!
Permission.where(name: 'Products', status: 1, icon: 'icon-product', path: '/products').first_or_create!
Permission.where(name: 'Roles & Permissions', status: 1, icon: 'icon-role', path: '/roles_permissions').first_or_create!
Permission.where(name: 'Create Incident', status: 1, icon: 'fa fa-plus-circle', path: '/incidents/new').first_or_create!
Permission.where(name: 'Boxes', status: 1, icon: 'icon-box', path: '/boxes').first_or_create!
Permission.where(name: 'LogBook', status: 1, icon: 'icon-log_book', path: '/logbooks').first_or_create!
Permission.where(name: 'Users', status: 1, icon: 'icon-user', path: '/users').first_or_create!
Permission.where(name: 'Reports', status: 1, icon: 'icon-reports', path: '/reports').first_or_create!
Permission.where(name: 'Settings', status: 1, icon: 'icon-settings', path: '/settings').first_or_create!
Permission.where(name: 'Dashboard', status: 1, icon: 'icon-dashboard', path: '/dashboard').first_or_create!

Role.all.each do |role|
  Permission.all.each do |permission|
    RolePermission.where(role_id: role.id, permission_id: permission.id).first_or_create!
  end
end

roles =  Role.where("title LIKE '%Admin%'")
roles.each do |role|
  role.role_permissions.update_all(is_readable: true, is_createable: true, is_updateable: true, is_deleteable: true)
end
