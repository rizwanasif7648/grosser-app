# frozen_string_literal: true

# Reports Helper for shared functions for Reports Module
module RolesHelper
  def editable?(role)
    role.permission.name == 'Requisition'
  end
end
