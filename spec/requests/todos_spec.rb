require 'rails_helper'

RSpec.describe 'Todos API', type: :request do

  let!(:todos) {create_list(:todo, 12)}
  let(:todo_id) {todos.first.id}

  describe 'GET/todos' do
    before { get '/todos'}

    it 'returns todos' do
      expect(json).not_to be_empty
      expect(json.size).to eq(12)
    end

  end

  describe 'GET /todos/:id' do
    before {get "/todos/#{todo_id}"}

    context 'when the todo item exists' do

      it 'should return the todo' do
        expect(json).not_to be_empty
        expect(json['id']).not_to eq(todo_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the todo item does not exist' do
      let(:todo_id) { 39}

      it 'should return status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'should return a not found message' do
        expect(response.body).to match(/Could not find this todo item. Please try again./)
      end
    end

  end

  describe 'POST /todos' do
    let(:valid_attributes) {{title: 'Develop a simple REST API', created_by: '1'}}

    context 'when the request is valid' do
      before {post '/todos', params: valid_attributes }

      it 'creates a todo' do
        expect(json['title']).to eq('Develop a simple REST API')
      end

    end

  end

end