require 'rspec'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

RSpec.shared_context "local paths" do
  def project_dir
    File.expand_path(File.join(File.dirname(__FILE__), '..'))
  end
end
 
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
  config.color = true
  config.formatter = :documentation
  config.tty = true
end
