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

end