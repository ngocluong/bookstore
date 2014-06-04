require 'timeout'

def wait_until
  Timeout.timeout(Capybara.default_wait_time) do
    sleep(0.5) unless yield
  end
end
