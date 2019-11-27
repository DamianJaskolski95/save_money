require 'rails_helper'

RSpec.describe 'Expenses API' do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let!(:category) { create(:category, created_by: user.id) }
  let!(:expenses) { create_list(:expense, 20, created_by: user.id, category_id: category.id) }
  let(:category_id) { category.id }
  let(:id) { expenses.first.id }
  let(:headers) { valid_headers }

  describe 'GET /categories/:category_id/expenses' do
    before { get "/categories/#{category_id}/expenses", params: {}, headers: headers }

    context 'when category exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all category expenses' do
        expect(json.size).to eq(20)
      end
    end

    context 'when category does not exist' do
      let(:category_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Category/)
      end
    end

    context 'when the user is different' do
      before { get "/categories/#{category_id}/expenses/", params: {}, headers: unauthorized_user_headers }

      it 'do not show the record' do
        expect(json['message']).to eq('Unauthorized request')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET /categories/:category_id/expenses/:id' do
    before { get "/categories/#{category_id}/expenses/#{id}", params: {}, headers: headers}

    context 'when category expense exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the expense' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when category expense does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Expense/)
      end
    end

    context 'when the user is different' do
      before { get "/categories/#{category_id}/expenses/#{id}", params: {}, headers: unauthorized_user_headers }

      it 'do not show the record' do
        expect(json['message']).to eq('Unauthorized request')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'POST /categories/:category_id/expenses' do
    let(:valid_attributes) { { expense_day: '2019-08-03', value: 10}.to_json }
    let(:invalid_attributes_value) { { expense_day: '2019-08-03', value: -10}.to_json }
    let(:invalid_attributes_date) { { expense_day: '2019-02-30', value: 10}.to_json }

    context 'when request attributes are valid' do
      before { post "/categories/#{category_id}/expenses", params: valid_attributes, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request attributes are invalid' do
      it 'for value' do
        post "/categories/#{category_id}/expenses", params: invalid_attributes_value, headers: headers
        expect(json['message']).to eq('Validation failed: Value must be greater than or equal to 0')
      end

      it 'for value expect status 422' do
        post "/categories/#{category_id}/expenses", params: invalid_attributes_value, headers: headers
        expect(response).to have_http_status(422)
      end

      it 'for date' do
        post "/categories/#{category_id}/expenses", params: invalid_attributes_date, headers: headers
        expect(json['message']).to be_nil
      end

      it 'for date expect status 422' do
        post "/categories/#{category_id}/expenses", params: invalid_attributes_date, headers: headers
        expect(response).to have_http_status(201)
      end
    end

    context 'when the user is different' do
      before { post "/categories/#{category_id}/expenses", params: valid_attributes, headers: unauthorized_user_headers }

      it 'do not show the record' do
        expect(json['message']).to eq('Unauthorized request')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'PUT /categories/:category_id/expenses/:id' do
    let(:valid_attributes) { { expense_day: '2019-08-08' }.to_json }
    let(:invalid_attributes) { { expense_day: '2019-02-30' }.to_json }

    context 'when expense exists' do
      before { put "/categories/#{category_id}/expenses/#{id}", params: valid_attributes, headers: headers }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'updates the expense' do
        updated_expense = Expense.find(id)
        expect(updated_expense.expense_day).to match(Date.new(2019,8,8))
      end
    end

    context 'when attributes are invalid' do
      before { put "/categories/#{category_id}/expenses/#{id}", params: invalid_attributes, headers: headers }

      it 'do not update the expense' do
        expect(json['message']).to be_nil
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the expense does not exist' do
      before { put "/categories/#{category_id}/expenses/#{id}", params: valid_attributes, headers: headers }
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Expense/)
      end
    end

    context 'when the user is different' do
      before { put "/categories/#{category_id}/expenses/#{id}", params: valid_attributes, headers: unauthorized_user_headers }

      it 'do not updates the record' do
        expect(json['message']).to eq('Unauthorized request')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'DELETE /expenses/:id' do
    context 'when the user is different' do
      before { delete "/categories/#{category_id}/expenses/#{id}", params: {}, headers: unauthorized_user_headers }

      it 'do not deletes the record' do
        expect(json['message']).to eq('Unauthorized request')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record exist' do
      before { delete "/categories/#{category_id}/expenses/#{id}", params: {}, headers: headers }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end
end
