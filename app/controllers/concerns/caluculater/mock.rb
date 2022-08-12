module Caluculater
  module Mock

    # mockの結果
    def mock_result_hash_index
      { on: nil, off: nil, wait_time: nil }
    end

    # mockの結果
    def test_result_struct_index
      @caluculated = result_struct(nil, mock_result_hash_index)
    end

    # mockの結果
    def mock_result_hash
      { on: 'Aバス', off: 'Bバス', wait_time: 10 }
    end

    def test_result_struct
      @caluculated = result_struct(current_time, mock_result_hash)
    end
  end
end


