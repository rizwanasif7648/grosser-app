# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'products/edit', type: :view do
  before(:each) do
    @product = FactoryBot.create(:product)
    assign(:product, @product)
  end

  it 'renders the edit product form' do
    render

    assert_select 'form[action=?][method=?]', product_path(@product), 'post' do
      assert_select 'input[name=?]', 'product[code]'

      assert_select 'input[name=?]', 'product[name]'

      assert_select 'input[name=?]', 'product[description]'

      assert_select 'select[name=?]', 'product[category]'

      assert_select 'select[name=?]', 'product[brand]'

      assert_select 'select[name=?]', 'product[asset_type]'

      assert_select 'select[name=?]', 'product[is_expirable]'

      assert_select 'input[name=?]', 'product[photo]'

      assert_select 'select[name=?]', 'product[status]'

      assert_select 'input[name=?]', 'product[created_by_id]'

      assert_select 'input[name=?]', 'product[updated_by_id]'
    end
  end
end
