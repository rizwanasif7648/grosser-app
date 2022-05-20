# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'boxes/show', type: :view do
  before(:each) do
    @box = FactoryBot.create(:box)
    assign(:box, @box)
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/2222/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/E3/)
    expect(rendered).to match(/type1/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/1/)
  end
end
