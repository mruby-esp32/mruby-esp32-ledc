class PWM
  attr_accessor :group, :channel, :timer, :resolution, :f, :d

  def initialize(pin = nil, **kwargs)
    self.group = kwargs[:group] || ESP32::LEDC_LOW_SPEED_MODE
    self.channel = kwargs[:channel] || ESP32::LEDC_CHANNEL_0
    self.timer = kwargs[:timer] || ESP32::LEDC_TIMER_0
    self.resolution = kwargs[:resolution] || ESP32::LEDC_TIMER_14_BIT

    f = kwargs[:freq] || kwargs[:frequency] || 1000
    d = kwargs[:duty] || 0

    ESP32::LEDC.timer_config(group, timer, resolution, f)
    ESP32::LEDC.channel_config(pin, group, timer, channel)

    self.frequency(f)
    self.duty(d)
  end

  def frequency(freq)
    self.f = freq
    print(self.f)
    ESP32::LEDC.set_freq(self.group, self.timer, self.f)
  end

  def period_us(micro_sec)
    frequency(Rational(1, Rational(micro_sec, 1_000_000)))
  end

  def duty(percent)
    self.d = Rational(percent, 100).to_i
    ESP32::LEDC.set_duty(self.group, self.channel, self.d)
  end

  def pulse_width_us(micro_sec)
    us_per_bit = Rational(1_000_000, self.f) / (2 ** self.resolution)
    duty((Rational(micro_sec, us_per_bit) * 100).to_i)
  end
end
