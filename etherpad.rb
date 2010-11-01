dep 'etherpad' do
  define_var :db_user, :default => 'etherpad'
  define_var :db_name, :default => 'etherpad'
  requires 'scala.managed', 'mysql access'
  met? { '/usr/local/etherpad/.git/'.p.file? }
  meet {
    log_shell 'Cloning etherpad git', 'git clone http://github.com/ether/pad.git /usr/local/etherpad'
    log_shell 'Building etherpad', 'cd /usr/local/etherpad/ && ./bin/build.sh'
  }
end
