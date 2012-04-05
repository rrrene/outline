class Outline::CreateExampleResources < Outline::Setup::CreateResources
  def run
    project :title => "Example Project" do
      page :title => "Example Page" do
        tag_list "red, green, blue"
      
        content_items do
          note :text => "This is a note. Notes can help you keeping track of things."
          link :href => "github.com", :title => "Github Homepage", :text => "This is a link. These are great to keep track of research or client websites."
          todo_list :title => "Todo List (1)" do
            content_items do
              todo :title => "Meet client"
              todo :title => "Do some research"
              todo :title => "Call accounting"
              todo :title => "Pickup milk"
            end
          end
        end
      end
    end
  end
end
