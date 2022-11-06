Rails.application.configure do
  hosts = ["k-bus-norikae-app.onrender.com", "0.0.0.0", "27e1-2409-10-a080-100-ed4b-a847-86b8-f613.ngrok.io"]
  hosts.each do |host|
    config.hosts << host
  end
end
