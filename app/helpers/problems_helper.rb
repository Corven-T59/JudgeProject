module ProblemsHelper
  def content_or_link uploader
    if @problem.descriptionFile.content_type == "text/plain"
      content_tag(:pre,content_tag(:code,File.read(uploader.file.file),class: "nohighlight"))
    else
      link_to("File",uploader.file_url)
    end
  end


end
