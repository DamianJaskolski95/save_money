require 'rails_helper'

RSpec.describe 'Categories API', type: :request do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:balance) { create(:balance, created_by: user.id) }
  let(:cycle) { create(:cycle, created_by: user.id, balance_id: balance.id)}
  let!(:categories) { create_list(:category, 10, created_by: user.id, cycle_id: cycle.id) }
  let(:category_id) { categories.first.id }
  let(:headers) { valid_headers }

  describe 'GET /categories' do
    before { get '/categories', params: {}, headers: headers }

    it 'returns categories' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /categories/:id' do
    before { get "/categories/#{category_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the category' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(category_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:category_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Category/)
      end
    end

    context 'when the user is different' do
      before { get "/categories/#{category_id}", params: {}, headers: unauthorized_user_headers }

      it 'do not show the record' do
        expect(json['message']).to eq('Unauthorized request')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'POST /categories' do
    let(:valid_attributes) { { name: 'Sweets', created_by: user.id.to_s, cycle_id: cycle.id }.to_json }

    context 'when the request is valid' do
      before { post '/categories', params: valid_attributes, headers: headers }

      it 'creates a category' do
        expect(json['name']).to eq('Sweets')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { title: nil, cycle_id: cycle.id }.to_json }
      before { post '/categories', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['message'])
          .to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  describe 'PUT /categories/:id' do
    let(:valid_attributes) { { name: 'Clothes12' }.to_json }

    context 'when the record exists' do
      before { put "/categories/#{category_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(json['name']).to eq('Clothes12')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the user is different' do
      before { put "/categories/#{category_id}", params: valid_attributes, headers: unauthorized_user_headers }

      it 'do not updates the record' do
        expect(json['message']).to eq('Unauthorized request')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'DELETE /categories/:id' do
    context 'when the user is different' do
      before { delete "/categories/#{category_id}", params: {}, headers: unauthorized_user_headers }

      it 'do not deletes the record' do
        expect(json['message']).to eq('Unauthorized request')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record exists' do
      before { delete "/categories/#{category_id}", params: {}, headers: headers }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end
end
