class DeviceEmitter
  # Emits a number to the device. We're currently emitting number of payroll events in last 5 minutes but this could be anything
  def self.emit!(number)
    device = Particle.device('LightEmitter')
    device.function('emit', number.to_s) if device.connected?
  end

  # Emits a pulse to the device. We're currently emitting every time payroll gets processed but this could be anything
  def self.g_pulse!(number)
    device = Particle.device('LightEmitter')
    device.function('gPulse', number.to_s) if device.connected?
  end
end