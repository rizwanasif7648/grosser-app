# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'roles/show', type: :view do
  before(:each) do
    @role = assign(:role, Role.create!(
                            title: 'Title',
                            status: 2,
                            created_by: 3,
                            updated_by: 4
                          ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
  end
end
