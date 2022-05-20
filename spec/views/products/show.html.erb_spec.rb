# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'products/show', type: :view do
  before(:each) do
    @product = FactoryBot.create(:product)
    assign(:product, @product)
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/22222/)
    expect(rendered).to match(/Test product/)
    expect(rendered).to match(/description/)
    expect(rendered).to match(/category1/)
    expect(rendered).to match(/brand1/)
    expect(rendered).to match(/asset_type_1/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/1/)
  end
end
