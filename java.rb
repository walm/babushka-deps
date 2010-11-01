dep 'java.managed' do
  installs {
    via :apt, 'openjdk-6-jdk' #'sun-java6-jdk'
  }
end

dep 'scala.managed' do
  requires 'java.managed'
  installs {
    via :apt, 'scala'
  }
end
