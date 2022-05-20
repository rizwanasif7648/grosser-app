# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'products/index', type: :view do
  before(:each) do
    @product = FactoryBot.create(:product)
    assign(:products, [@product])
  end

  it 'renders a list of products' do
    render
    assert_select 'tr>td', text: '22222'.to_s, count: 1
    assert_select 'tr>td', text: 'Test product'.to_s, count: 1
    assert_select 'tr>td', text: 'description'.to_s, count: 1
    assert_select 'tr>td', text: 'category1'.to_s, count: 1
    assert_select 'tr>td', text: 'brand1'.to_s, count: 1
    assert_select 'tr>td', text: 'asset_type_1'.to_s, count: 1
    assert_select 'tr>td', text: false.to_s, count: 1
    assert_select 'tr>td', text: 1.to_s, count: 1
    assert_select 'tr>td', text: 1.to_s, count: 1
    assert_select 'tr>td', text: 1.to_s, count: 1
  end
end
