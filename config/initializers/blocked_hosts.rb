Rails.application.configure do
  hosts = ["k-bus-norikae-app.onrender.com", "0.0.0.0"]
  hosts.each do |host|
    config.hosts << host
  end
end
