module ProblemsHelper
  def content_or_link object, uploader
    if object.send(uploader).content_type == "text/plain"
      content_tag(:pre,content_tag(:code,File.read(object.send(uploader).file.file),class: "nohighlight"))
    else
      link_to("File", object.send(uploader).url)
    end
  end

  def display_add_problem_button
    if user_can_edit && @contest == nil
      content_tag(:div, class: "top-float-button top-space") do
        content_tag(:a, content_tag(:i, "add", class: "material-icons"), class: "btn btn-danger btn-fab", style: "background-color: #CC342D;", "data-toggle": "modal", "data-target": "#myModal")
      end
    end
  end

  def create_problem_modal_body new_problem
    if @contest == nil
    	form_for(new_problem, html: {multipart: true}, builder: BootstrapFormBuilder) do |f|
    		content_tag(:div, class: "modal-body") do
    			render :partial => "problems/fields", :locals => {:f => f} 
    		end +
    		
    		content_tag(:div, class: "modal-footer") do
    			content_tag(:button, "Cerrar", class: "btn btn-default", "data-dismiss": "modal") +		
    			button_tag("Crear", class: "btn btn-primary")
    		end
      end
    end
  end

  def codeforces_url problem
    "http://codeforces.com/problemset/problem/#{problem.codeforces_contest_id}/#{problem.codeforces_index}"
  end
end
