# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'boxes/new', type: :view do
  before(:each) do
    @box = FactoryBot.create(:box)
    assign(:box, @box)
  end

  it 'renders new box form' do
    render

    assert_select 'form[action=?][method=?]', boxes_path, 'post' do
      assert_select 'input[name=?]', 'box[code]'

      assert_select 'input[name=?]', 'box[customer_id]'

      assert_select 'input[name=?]', 'box[location]'

      assert_select 'input[name=?]', 'box[type]'

      assert_select 'input[name=?]', 'box[status]'

      assert_select 'input[name=?]', 'box[min_boxs]'

      assert_select 'input[name=?]', 'box[max_boxs]'

      assert_select 'input[name=?]', 'box[created_by_id]'

      assert_select 'input[name=?]', 'box[updated_by_id]'
    end
  end
end
