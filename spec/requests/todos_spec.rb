require 'rails_helper'

RSpec.describe 'Todos API', type: :request do

  let(:user) { create_user(:user) }
  let!(:todos) { create_list(:todo, 12) }
  let(:todo_id) { todos.first.id}

  describe 'GET/todos' do
    before { get '/todos', params: {}, headers: headers}

    it 'returns todos' do
      expect(json).not_to be_empty
      expect(json.size).to eq(12)
    end

  end

  describe 'GET /todos/:id' do
    before {get "/todos/#{todo_id}", params: {}, headers: headers}

    context 'when the todo item exists' do

      it 'should return the todo' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(todo_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the todo item does not exist' do
      let(:todo_id) { 903 }

      it 'should return a not found message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end
    end

  end

  describe 'POST /todos' do
    let(:valid_attributes) { { title: 'Develop a simple REST API', created_by: user.id.to_s  } }.to_json

    context 'when request is valid' do
      before {post '/todos', params: valid_attributes, headers: headers }

      it 'should create a todo' do
        expect(json['title']).to eq('Develop a simple REST API')
      end

      it 'should return status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:valid_attributes) { { title: nil }.to_json }

      before { post '/todos', params: valid_attributes, headers: headers }

      it 'should return status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'should return a failure message' do
        expect(response.body).to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  describe 'PUT /todos/:id' do
    let(:valid_attributes) { { title: 'Write a technical article in FatosMorina.com' }.to_json }

    context 'when the record exists' do
      before { put "/todos/#{todo_id}", params: valid_attributes, headers: headers }

      it 'should update the record' do
        expect(response.body).to be_empty
      end

      it 'should return status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /todos/:id' do
    before { delete "/todos/#{todo_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
