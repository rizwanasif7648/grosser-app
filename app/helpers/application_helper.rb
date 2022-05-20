# frozen_string_literal: true

# Application Helper for shared functions accross application
module ApplicationHelper
  def accessable?(permission_name, action)
    Permission.authorized?(current_user.role.id, permission_name, action)
  end

  def permissible?(permission_name)
    accessable?(permission_name, 'is_readable') ||
      accessable?(permission_name, 'is_updateable') ||
      accessable?(permission_name, 'is_deleteable')
  end

  def date(date)
    date ? date.strftime('%d-%B-%Y') : 'N/A'
  end

  def link_to_add_row(name, form, association, **args)
    new_object = form.object.send(association).klass.new
    id = new_object.object_id
    fields = form.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize, f: builder)
    end
    link_to(name, '#', class: 'add_fields ' + args[:class],
                       data: { id: id, fields: fields.gsub("\n", '') })
  end

  def super_admin
    accessable?('Customers', 'is_readable') || accessable?('Products', 'is_readable') ||
      accessable?('Roles & Permissions', 'is_readable') ||
      accessable?('Create Incident', 'is_readable')
  end

  def date_format(date)
    date.strftime('%B %d, %Y')
  end

  def time_format(time)
    time.strftime('%I:%M %P')
  end

  def expiry(date)
    date ? date.strftime("%d/%m/%Y") : 'N/A'
  end
end
