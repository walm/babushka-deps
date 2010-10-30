meta :shell_setup do
  template {
    met? { grep which(name), '/etc/shells' }
    meet { append_to_file which(name), '/etc/shells', :sudo => true }
  }
end

dep 'zsh.shell_setup' do
  requires 'zsh'
end
