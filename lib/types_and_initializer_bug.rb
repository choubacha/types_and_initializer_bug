require 'dry-types'
require 'dry-initializer'

module TypesAndInitializerBug
  class Types
    include Dry::Types.module
  end

  class Broken
    extend Dry::Initializer

    param :arg, Types::Array.of(Types::Int), default: -> { [1, 2] }
  end

  class Wrapped
    extend Dry::Initializer

    param :arg, -> (input) { Types::Array.of(Types::Int).call(input) }, default: -> { [1, 2] }
  end
end
