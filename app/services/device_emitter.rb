class DeviceEmitter
  # Emits a number to the device. We're currently emitting number of payroll events in last 5 minutes but this could be anything
  def self.emit!(number)
    sendMessage('emit', number.to_s)
  end

  # Emits a pulse to the device. We're currently emitting every time payroll gets processed but this could be anything
  def self.g_pulse!(number)
    sendMessage('gPulse', number.to_s)
  end

  def self.sendMessage(message, data)
    begin
      device = Particle.device('LightEmitter')
      device.function(message, data) if device.connected?
    rescue Particle::BadRequest
    end
  end
end