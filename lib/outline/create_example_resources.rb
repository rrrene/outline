class Outline::CreateExampleResources < Outline::Setup::CreateResources
  def run
    project :title => "Outline (Example Project)", :description => "This is the example project." do
      tag_list "red, green, blue"

      content_items do
        note :text => "This is a note. Notes can help you keeping track of things."
        note :text => "For example, you can post notes to projects like this one.\n\n**This project was created on your request** to demonstrate some _basic_ features of `Outline`."
        note :text => "    <-- Checkout the sub page in the navigation as well.\n        Pages are a great way to collect knowledge and ideas around a topic."
        link :href => "github.com", :title => "Github Homepage", :text => "**This is a link.** These are great to keep track of research or client websites."
        note :text => "Also a great way to collect things from the web:\n\n![XKCD Good Code](http://imgs.xkcd.com/comics/good_code.png)"
      end
      page :title => "To-Dos (Example Page)" do
        tag_list "red, green, blue"
      
        content_items do
          note :text => "Basically you can post whatever you like to a page or project.\n\nIn this case, we made a page dedicated to todo-lists for different scenarios:"
          todo_list :title => "Todo List (best case)" do
            content_items do
              todo :title => "Get things done"
              todo :title => "Raise a gazillion bucks"
              todo :title => "World Domination"
              todo :title => "Pickup milk"
            end
          end
          todo_list :title => "Todo List (real life)" do
            content_items do
              todo :title => "Meet a client"
              todo :title => "Do some research beforehand"
              todo :title => "Wait for call"
              todo :title => "Go drinking"
            end
          end
        end
      end
    end
  end
end
