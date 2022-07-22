module Common
  extend ActiveSupport::Concern

  def current_time
    Time.zone.now
  end

  def result_struct(now, hash)
    caluculator = Struct.new(:now, :on, :off, :wait_time)
    caluculator.new(now, hash[:on], hash[:off], hash[:wait_time])
  end

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
