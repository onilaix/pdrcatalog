# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
=begin
get "pdr_logs/index"

get "ret_codes/edit"

get "pdrs/index"

get "ret_codes/index"

get "pdr_list/index"

get "mvno_procs/index"
=end

#get "pdrcatalog" => "mvno_procs#index"
get "mvno_procs" => "mvno_procs#index"
get "pdrs" => "pdrs#index"


resources :mvno_procs

resources :pdrs do
  resources :ret_codes
  get 'log', :on => :collection
  get 'dwh', :on => :collection
end

