class DeviceEmitter
  # Emits a number to the device. We're currently emitting number of payroll events in last 5 minutes but this could be anything
  def self.emit!(number)
    device = Particle.device('LightEmitter')
    device.function('emit', number.to_s)
  end
end