# frozen_string_literal: true

# Settings Helper for shared functions for Settings Module
module SettingsHelper
  def snake_case_to_normal_case(str)
    str.split('_').join(' ').titleize
  end
end
