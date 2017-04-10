require 'rails_helper'

RSpec.describe User, type: :model do

  it { should have_many(:todos) }

  it { should validate_presence_of(:name) }

  it { should validiate_presence_of(:email) }

end
