module ApplicationHelper
  def mensaje_image_tag(image)
	attachments.inline[image] = File.read(Rails.root.join("data/#{image}"))
    image_tag attachments[image].url, style: 'width:800px;height:auto;'
  end
end
