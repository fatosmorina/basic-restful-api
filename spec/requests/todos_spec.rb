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

    context 'when the record exists' do

      it 'should return the todo' do
        expect(json).not_to be_empty
        expect(json['id']).not_to eq(todo_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

    end
  end

end