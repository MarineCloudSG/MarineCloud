# https://gist.github.com/md-farhan-memon/4fa1df2c19e8acec60a9eb2e2e1235b7
class VideoEmbedUrlGenerator
  # rubocop:disable Layout/LineLength
  REGEX_ID = %r{(?:youtube(?:-nocookie)?\.com/(?:[^/\n\s]+/\S+/|(?:v|e(?:mbed)?)/|\S*?[?&]v=)|youtu\.be/|vimeo\.com/)([a-zA-Z0-9_-]{8,11})}
  # rubocop:enable Layout/LineLength
  REGEX_PROVIDER = /(youtube|youtu\.be|vimeo)/

  def initialize(url)
    @url = url
  end

  def construct_iframe
    '<iframe '\
      'width="100%" '\
      'height="480px" '\
      'style="padding: 10px;" '\
      'frameborder="0" '\
      'allow="autoplay; fullscreen" '\
      'allowfullscreen, '\
      "src='#{construct_url}'>"\
    '</iframe>'
  end

  def construct_url
    case video_provider
    when :youtube
      "https://www.youtube.com/embed/#{video_id}"
    when :vimeo
      "https://player.vimeo.com/video/#{video_id}"
    end
  end

  private

  attr_accessor :url

  def video_provider
    case matched_result(REGEX_PROVIDER)
    when 'youtube', 'youtu.be'
      :youtube
    when 'vimeo'
      :vimeo
    end
  end

  def video_id
    matched_result(REGEX_ID)
  end

  def matched_result(regex)
    match = regex.match(url)
    return if match.blank? || match[1].blank?

    match[1]
  end
end
