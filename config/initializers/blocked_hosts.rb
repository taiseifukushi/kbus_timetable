Rails.application.configure do
  hosts = [
    "kbus-timetable-husita-h.onrender.com",
    "kbus-timetable-husita-h-staging.onrender.com",
    "0.0.0.0"
  ]
  hosts.each do |host|
    config.hosts << host
  end
end
