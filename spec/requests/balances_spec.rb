require 'rails_helper'

RSpec.describe 'Balances API', type: :request do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let!(:balances) { create_list(:balance, 12, created_by: user.id) }
  let(:id) { balances.first.id }
  let(:headers) { valid_headers }

  describe 'GET /balances' do
    before { get "/balances", params: {}, headers: headers }

    it 'returns all user balances' do
      expect(json).not_to be_empty
      expect(json.size).to eq(12)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /balances/:id' do
    before { get "/balances/#{id}", params: {}, headers: headers}

    context 'when balance exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the balance' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when balance does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Balance/)
      end
    end

    context 'when the user is different' do
      before do
        get "/balances/#{id}", params: {}, headers: unauthorized_user_headers
      end

      it 'do not show the record' do
        expect(json['message']).to match('Unauthorized request')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'POST /balances' do
    let(:valid_attributes) do
      {
        income: 6000,
        balance_date: "2019-10-1",
        planned_savings: 2000,
        savings: 0,
        created_by: user.id
      }.to_json
    end
    let(:invalid_attributes_month) do
      {
        income: 6000,
        balance_date: "2019-100-1",
        planned_savings: 2000,
        savings: 10,
        created_by: user.id
      }.to_json
    end
    let(:invalid_attributes_planned_savings) do
      {
        income: 6000,
        balance_date: "2019-10-1",
        planned_savings: -2000,
        savings: 10,
        created_by: user.id
      }.to_json
    end

    context 'when request attributes are valid' do
      before { post "/balances", params: valid_attributes, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request attributes are invalid' do
      it 'for planned_savings' do
        post "/balances", params: invalid_attributes_planned_savings, headers: headers
        expect(json['message']).to match('Validation failed: Planned savings must be greater than or equal to 0')
      end

      it 'for planned_savings expect status 422' do
        post "/balances", params: invalid_attributes_planned_savings, headers: headers
        expect(response).to have_http_status(422)
      end

      it 'for month expect status 201' do
        post "/balances", params: invalid_attributes_month, headers: headers
        expect(response).to have_http_status(201)
      end
    end
  end

  describe 'PUT /balances/:id' do
    let(:valid_attributes) { { income: 200.20 }.to_json }
    let(:invalid_attributes) { { income: -200 }.to_json }

    context 'when balance exists' do
      before { put "/balances/#{id}", params: valid_attributes, headers: headers }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'updates the balance' do
        updated_balance = Balance.find(id)
        expect(updated_balance.income).to match(200.20)
      end
    end

    context 'when attributes are invalid' do
      before { put "/balances/#{id}", params: invalid_attributes, headers: headers }

      it 'do not update the balance' do
        expect(json['message']).to match('Entered value is not valid.')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the balance does not exist' do
      before { put "/balances/#{id}", params: valid_attributes, headers: headers }
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Balance/)
      end
    end

    context 'when the user is different' do
      before { put "/balances/#{id}", params: valid_attributes, headers: unauthorized_user_headers }

      it 'do not updates the record' do
        expect(json['message']).to match('Unauthorized request')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'DELETE /balances/:id' do
    context 'when the user is different' do
      before { delete "/balances/#{id}", params: {}, headers: unauthorized_user_headers }

      it 'do not deletes the record' do
        expect(json['message']).to match('Unauthorized request')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record exist' do
      before { delete "/balances/#{id}", params: {}, headers: headers }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end


    context 'when the record does not exist' do
      before { delete "/balances/#{id}", params: {}, headers: headers }
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Balance/)
      end
    end
  end
end
