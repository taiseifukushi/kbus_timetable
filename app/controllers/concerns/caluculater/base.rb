module Caluculater
  module Base
    extend ActiveSupport::Concern

    included do
      include Caluculater::Common
      include Caluculater::Mock
    end
  end
end