require 'timeout'

Capybara.default_wait_time = 20

def wait_until(timeout = Capybara.default_wait_time)
  Timeout.timeout(timeout) do
    sleep(0.5) until yield == true
  end
end
