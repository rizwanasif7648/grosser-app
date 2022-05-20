# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'products/new', type: :view do
  before(:each) do
    @product = FactoryBot.create(:product)
    assign(:product, @product)
  end

  it 'renders new product form' do
    render

    assert_select 'form[action=?][method=?]', products_path, 'post' do
      assert_select 'input[name=?]', 'product[code]'

      assert_select 'input[name=?]', 'product[name]'

      assert_select 'input[name=?]', 'product[description]'

      assert_select 'input[name=?]', 'product[category]'

      assert_select 'input[name=?]', 'product[brand]'

      assert_select 'input[name=?]', 'product[asset_type]'

      assert_select 'input[name=?]', 'product[is_expirable]'

      assert_select 'input[name=?]', 'product[photo]'

      assert_select 'input[name=?]', 'product[status]'

      assert_select 'input[name=?]', 'product[created_by_id]'

      assert_select 'input[name=?]', 'product[updated_by_id]'
    end
  end
end
