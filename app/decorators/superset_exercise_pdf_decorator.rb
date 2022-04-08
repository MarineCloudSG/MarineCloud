# require 'rqrcode'

class SupersetExercisePDFDecorator < ApplicationDecorator
  delegate_all

  def exercise_name
    object.exercise.name
  end

  def youtube_url
    object.exercise.youtube_url
  end

  def youtube_qr
    qr = RQRCode::QRCode.new(object.exercise.youtube_url)

    qr.as_svg(
      module_size: 1,
      viewbox: "0 0 4 4"
    )
  end
end
