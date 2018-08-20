class java::params {
  case $::osfamily {
    'RedHat': {
       case $::operatingsystem {
          'CentOS','OracleLinux': {
             if(versioncmp($::operatingsystemrelease, '5') < 0) {
               $jdk_package = 'java-1.6.0-sun-devel'
               $jre_package = 'java-1.6.0-sun'
               $java_home = '/usr/lib/jvm/java-1.6.0-sun/jre/'
                }
             elsif(versioncmp($::operatingsystemrelease, '6.3') < 0) {
               $jdk_package = 'java-1.6.0-openjdk-devel'
               $jre_package = 'java-1.6.0-openjdk'
               $java_home = '/usr/lib/jvm/java-1.6.0/'
                }
             elsif(versioncmp($::operatingsystemrelease, '7.1') < 0) {
               $jdk_package = 'java-1.7.0-openjdk-devel'
               $jre_package = 'java-1.7.0-openjdk'
               $java_home = '/usr/lib/jvm/java-1.7.0/'
                }
             else {
               $jdk_package = 'java-1.8.0-openjdk-devel'
               $jre_package = 'java-1.8.0-openjdk'
               $java_home = '/usr/lib/jvm/java-1.8.0/'
                }
              }
          'Fedora': {
             if(versioncmp($::operatingsystemrelease, '21') < 0) {
             $jdk_package = 'java-1.7.0-openjdk-devel'
             $jre_package = 'java-1.7.0-openjdk' 
             $java_home = "java-1.7.0-openjdk'-{$::architecture}/" 
                }
             }
           default: {
             notify { "Unsupported Operating system ($::operatingsystemrelease)" : }
             }
           }
       $java = { 'jdk' => { 'package' => $jdk_package, 'java_home' => $java_home},
               'jre' => { 'package' => $jre_package, 'java_home' => $java_home } }
       notify { "java variables are $java" : }
        }
     'Debian': {
        if($::architecture == 'amd64') {
           $oracle_architecture = 'x64'
          }
        else {
           $oracle_architecture = $::architecture
          }
        case $::libdistcodename { 
          'lenny', 'squeeze', 'lucid', 'natty': {
             $java = { 'jdk' => { 'package' => 'openjdk-6-jdk', 'alternative' => "java-6-openjdk-${::architecture}",
                                  'alternative_path' => '/usr/lib/jvm/java-6-openjdk/jre/bin/java', 
                                  'java_home'        => '/usr/lib/jvm/java-6-openjdk/jre/' },
                        'jre' => { 'package'          => 'openjdk-6-jre-headless', 'alternative' => "java-6-openjdk-${::architecture}",
                                   'alternative_path' => '/usr/lib/jvm/java-6-openjdk/jre/bin/java',
                                   'java_home'        => '/usr/lib/jvm/java-6-openjdk/jre/'} }
                      }
          default: {
             notify { "Unsupported Operating system ($::libdistcodename)": }
              }
           }
        }
     default: {
       notify { "Unsupported Operating system ($::operatingsystem)" :}
      }
   }
}
