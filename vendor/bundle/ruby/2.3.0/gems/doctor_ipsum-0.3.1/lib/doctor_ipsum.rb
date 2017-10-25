mydir = File.expand_path(File.dirname(__FILE__))

require 'i18n'
I18n.load_path += Dir[File.join(mydir,'locales','*.yml')]
I18n.reload!

module DoctorIpsum
  class Base
    class << self
      def fetch(from)
        I18n.translate(from)
      end
    end
  end
end

require 'doctor_ipsum/version'
require 'doctor_ipsum/lorem'
require 'doctor_ipsum/markdown'
