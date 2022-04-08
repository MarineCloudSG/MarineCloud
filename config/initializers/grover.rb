if Rails.env.development?
  Grover.configure do |config|
    config.use_pdf_middleware = false
    config.options = {
      format: 'A4',
      margin: {
        top: '0.39in',
        left: '0.39in',
        bottom: '0.38in',
        right: '0.38in'
      },
      display_url: 'http://localhost:3000',
      landscape: true,
      display_header_footer: false,
      # footer_template: "<span class='pageNumber'></span>/<span class='totalPages'></span>"
      # debug: {
      #   headless: false,  # Default true. When set to false, the Chromium browser will be displayed
      #   devtools: true    # Default false. When set to true, the browser devtools will be displayed.
      # }
    }
  end
else
  Grover.configure do |config|
    config.use_pdf_middleware = false
    config.options = {
      format: 'A4',
      margin: {
        top: '0.39in',
        left: '0.39in',
        bottom: '0.38in',
        right: '0.38in'
      },
      emulate_media: 'screen',
      display_url: 'https://marinecloud.dev',
      landscape: true,
      display_header_footer: false
    }
  end
end
