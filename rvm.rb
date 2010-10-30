dep 'rvm' do
  helper(:path) {
    "~/.rvm/scripts/rvm"
  }
  met? {
    path.p.file?
  }
  meet {
    log_shell 'Installing rvm', 'bash -c "`curl http://rvm.beginrescueend.com/releases/rvm-install-head`"'
    shell 'source "$HOME/.rvm/scripts/rvm"'
  }
end

meta :rvm_ruby do
  template {
    requires 'rvm'
    met? { shell("rvm list").include? name }
    meet { log_shell "Getting #{name} with rvm", "rvm install #{name}" }
  }
end

dep 'ruby-1.8.7', :template => 'rvm_ruby'

dep 'ruby-1.9.2', :template => 'rvm_ruby'

dep 'jruby', :template => 'rvm_ruby'

dep 'rvm all' do
  requires 'rvm', 'ruby-1.8.7', 'ruby-1.9.2', 'jruby'
end
