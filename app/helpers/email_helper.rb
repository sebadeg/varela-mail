module EmailHelper
    def email_image_tag(image, **options)
		attachments.inline[image] = File.read(Rails.root.join("public/#{image}"))
        image_tag attachments[image].url, **options
    end
end