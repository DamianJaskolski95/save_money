require 'rails_helper'

RSpec.describe 'Expenses API' do
  let!(:category) { create(:category) }
  let!(:expenses) { create_list(:expense, 20, category_id: category.id) }
  let(:category_id) { category.id }
  let(:id) { expenses.first.id }

  describe 'GET /categories/:category_id/expenses' do
    before { get "/categories/#{category_id}/expenses" }

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
  end

  describe 'GET /categories/:category_id/expenses/:id' do
    before { get "/categories/#{category_id}/expenses/#{id}" }

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
  end

  describe 'POST /categories/:category_id/expenses' do
    let(:valid_attributes) { { month: 1, planned_value: 100, value: 10} }

    context 'when request attributes are valid' do
      before { post "/categories/#{category_id}/expenses", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/categories/#{category_id}/expenses", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Month can't be blank/)
      end
    end
  end

  describe 'PUT /categories/:category_id/expenses/:id' do
    let(:valid_attributes) { { month: 1 } }

    before { put "/categories/#{category_id}/expenses/#{id}", params: valid_attributes }

    context 'when expense exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the expense' do
        updated_expense = Expense.find(id)
        expect(updated_expense.month).to match(/1/)
      end
    end

    context 'when the expense does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Expense/)
      end
    end
  end

  describe 'DELETE /expenses/:id' do
    before { delete "/categories/#{category_id}/expenses/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
