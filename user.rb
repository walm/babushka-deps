dep 'user shell setup' do
  requires 'zsh', 'dotfiles'
  met? { File.basename(sudo('echo \$SHELL', :as => var(:username), :su => true)) == 'zsh' }
  meet { sudo "chsh -s #{shell('which zsh')} #{var(:username)}" }
end

dep 'passwordless ssh logins' do
  met? { grep var(:your_ssh_public_key), '~/.ssh/authorized_keys' }
  before { shell 'mkdir -p ~/.ssh; chmod 700 ~/.ssh' }
  meet { append_to_file var(:your_ssh_public_key), "~/.ssh/authorized_keys" }
  after { shell 'chmod 600 ~/.ssh/authorized_keys' }
end

dep 'public key' do
  met? { grep /^ssh-dss/, '~/.ssh/id_dsa.pub' }
  meet { shell("ssh-keygen -t dsa -f ~/.ssh/id_dsa -N ''").tap_log }
end

dep 'dotfiles' do
  requires 'git'
  met? { File.exists?(ENV['HOME'] / ".dotfiles/.git") }
  meet { log_shell "Installing dotfiles from git", %Q{curl -L "http://github.com/#{var :github_user, :default => 'walm'}/#{var :dotfiles_repo, :default => 'dotfiles'}/raw/master/install.sh" | bash} }
end

dep 'user exists' do
  setup {
    define_var :home_dir_base, :default => L{
      var(:username)['.'] ? '/srv/http' : '/home'
    }
  }
  on :osx do
    met? { !shell("dscl . -list /Users").split("\n").grep(var(:username)).empty? }
    meet {
      homedir = var(:home_dir_base) / var(:username)
      {
        'Password' => '*',
        'UniqueID' => (501...1024).detect {|i| (Etc.getpwuid i rescue nil).nil? },
        'PrimaryGroupID' => 'admin',
        'RealName' => var(:username),
        'NFSHomeDirectory' => homedir,
        'UserShell' => '/dev/null'
      }.each_pair {|k,v|
        # /Users/... here is a dscl path, not a filesystem path.
        sudo "dscl . -create #{'/Users' / var(:username)} #{k} '#{v}'"
      }
      sudo "mkdir -p '#{homedir}'"
      sudo "chown #{var(:username)}:admin '#{homedir}'"
      sudo "chmod 701 '#{homedir}'"
    }
  end
  on :linux do
    met? { grep(/^#{var(:username)}:/, '/etc/passwd') }
    meet {
      sudo "mkdir -p #{var :home_dir_base}" and
      sudo "useradd -m -s /bin/bash -b #{var :home_dir_base} -G admin #{var(:username)}" and
      sudo "chmod 701 #{var(:home_dir_base) / var(:username)}"
    }
  end
end

dep 'www user and group' do
  www_name = Babushka::Base.host.osx? ? '_www' : 'www'
  met? { grep(/^#{www_name}\:/, '/etc/passwd') and grep(/^#{www_name}\:/, '/etc/group') }
  meet {
    sudo "groupadd #{www_name}"
    sudo "useradd -g #{www_name} #{www_name} -s /bin/false"
  }
end
