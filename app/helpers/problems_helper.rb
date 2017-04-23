module ProblemsHelper
  def content_or_link object, uploader
    if object.send(uploader).content_type == "text/plain"
      content_tag(:pre,content_tag(:code,File.read(object.send(uploader).file.file),class: "nohighlight"))
    else
      link_to("File", object.send(uploader).url)
    end
  end
end
