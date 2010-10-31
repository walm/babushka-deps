dep 'client' do
  requires {
   on :osx, 'xcode tools', 'brew', 'rsync', 'user shell setup', 'LaunchBar.app', 'Skitch.app', 'Skype.app', 'Google Chrome.app', 'Firefox.app', 'LimeChat.app', 'Echofon.app', 'Cloud.app', 'Cinch.app'
  }
end

dep 'develop' do
  requires {
    on :osx, 'client', 'rvm all', 'Transmit.app', 'HTTP Client.app', 'xScope.app', 'Titanium Developer.app', 'Kaleidoscope.app'
  }
end

dep 'server' do
  requires {
    on :linux, 'passwordless ssh logins', 'webserver running.nginx'
  }
end
