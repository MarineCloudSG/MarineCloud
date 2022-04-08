module Webpages
  class DefaultDomainNameFromEmail < Patterns::Calculation
    def result
      subject.split('@').first + '001'
    end
  end
end
