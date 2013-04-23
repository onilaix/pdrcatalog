Redmine::Plugin.register :pdrcatalog do
  name 'Pdrcatalog plugin'
  author 'Marco Scialino'
  description 'Catalogo PDR record per MVNO'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'

  #permission :pdrcatalog, { :mvno_procs => [:index, :new] }, :public => false
  project_module :pdrcatalog do
    permission :mvno_procs, {:mvno_procs => [:index, :new, :create, :update, :edit, :destroy]}, :require => :loggedin
    permission :pdrs, {:pdrs => [:index, :new, :create,:show, :update, :edit, :destroy, :search]}, :require => :loggedin
    permission :ret_codes, {:ret_codes => [:index, :new, :create,:show, :update, :edit, :destroy ]}, :require => :loggedin
    permission :dwh, {:dwh => [:index]}, :require => :loggedin
    permission :log, {:log => [:index]}, :require => :loggedin

#    permission :proc_index, :mvno_procs => :index
#    permission :proc_new, :mvno_procs => :new
#    permission :proc_show, :mvno_procs => :show
#    permission :proc_edit, :mvno_procs => :edit
#    permission :proc_create, :mvno_procs => :create
#    permission :proc_update, :mvno_procs => :update
#    permission :proc_destroy, :mvno_procs => :destroy

  end
#  permission :pdrcatalog, { :mvno_procs => [:index, :new] }, :public => true
  menu :project_menu, :mvno_procs, { :controller => 'pdrs', :action => 'index' }, :caption => 'Catalogo PDR', :last => true, :param => :project_id

#  menu :project_menu, :pdrcatalog, { :controller => 'mvno_procs', :action => 'index' }, :caption => 'Processi MVNO', :after => :activity, :param => :project_id

end
