MailsViewer::Engine.routes.draw do
  controller "home" do
    get "/index" => 'home#index', to: :index
    get "/raw" => 'home#raw', to: :raw
    get "/html" => 'home#html', to: :html
    get "/plain" => 'home#plain', to: :plain
    get '/attachment' => 'home#attachment', to: :attachment
  end
  root to: 'home#index'
end
