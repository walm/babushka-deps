dep 'dock with stacklist' do
  met? { false }
  meet { log_shell "Enable stacklist in dock", "defaults write com.apple.dock use-new-list-stack -bool #{var(:enable_stacklist, :default => 'YES')}  && killall Dock" }
end

dep 'dock with list' do
  define_var :enable_stacklist => 'NO'
  requires 'dock with stacklist'
end
