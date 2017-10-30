require "spec_helper"

RSpec.describe TypesAndInitializerBug do
  context TypesAndInitializerBug::Broken do
    it 'loads the inited fine' do
      TypesAndInitializerBug::Broken.new
    end
  end

  context TypesAndInitializerBug::Wrapped do
    it 'loads the inited fine' do
      TypesAndInitializerBug::Wrapped.new
    end
  end
end
