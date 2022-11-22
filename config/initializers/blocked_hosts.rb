Rails.application.configure do
  hosts = ["https://kbus-timetable.onrender.com", "0.0.0.0"]
  hosts.each do |host|
    config.hosts << host
  end
end
