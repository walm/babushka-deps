dep 'Google Chrome.app' do
  source 'http://dl.google.com/chrome/mac/dev/GoogleChrome.dmg'
end

dep 'Dropbox.app' do
  source 'http://cdn.dropbox.com/Dropbox%200.7.110.dmg'
end

dep 'LaunchBar.app' do
  source 'http://www.obdev.at/downloads/launchbar/LaunchBar-5.0.3.dmg'
end

dep 'Skype.app' do
  source 'http://download.skype.com/macosx/Skype_2.8.0.851.dmg'
end

dep 'Transmit.app' do
  source 'http://www.panic.com/transmit/d/Transmit 4.0.zip'
end

dep 'Echofon.app' do
  source 'http://www.echofon.com/twitter/mac/bin/Echofon.dmg'
end

dep 'Skitch.app' do
  source 'http://get.skitch.com/skitch-beta.dmg'
end

dep 'HTTP Client.app' do
  source 'http://ditchnet.org/httpclient/dist/HTTPClient.zip'
end

dep 'LimeChat.app' do
  source 'http://cloud.github.com/downloads/psychs/limechat/LimeChat_2.15.tbz'
  after {
    themes_path = '"$HOME/Library/Application Support/LimeChat/Themes"' 
    ir_black = "http://github.com/jschoolcraft/Limechat-Themes/raw/master/ir_black/ir_black"
    log_shell "Adding ir_black theme", "mkdir -p #{themes_path} && cd #{themes_path} && curl -O #{ir_black}.css && curl -O #{ir_black}.png && curl -O #{ir_black}.yaml"
  }
end

dep 'Firefox.app' do
  source 'http://download.mozilla.org/?product=firefox-3.6.12&os=osx&lang=en-US' 
end

dep 'xScope.app' do
  source 'http://iconfactory.com/assets/software/xscope/xScope_222.zip'
end

dep 'Titanium Developer.app' do
  source 'http://www.appcelerator.com/download-osx'
end

dep 'Cloud.app' do
  source 'http://f.cl.ly.s3.amazonaws.com/builds/CloudApp1.0.3.zip'
end

dep 'Kaleidoscope.app' do
  source 'http://d38sv94p198wrl.cloudfront.net/1.0.2_24/Kaleidoscope.zip'
end
