dep 'brew' do
  met? { which 'brew' }
  meet { shell 'ruby -e "$(curl -fsS http://gist.github.com/raw/323731/install_homebrew.rb)"' }
end

meta :brew do
  template {
    requires 'brew'
    met? { which name }
    meet { log_shell "Brewing #{name}", "brew install #{name}" }
  }
end

dep 'macvim', :template => 'brew' do
  after { shell "ln -s /usr/local/bin/mvim /usr/local/bin/macvim" }
end

dep 'zsh', :template => 'brew'

dep 'ack', :template => 'brew'

dep 'rsync', :template => 'brew'

