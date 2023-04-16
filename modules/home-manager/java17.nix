{pkgs, ...}: let
  jdkVersion = "17";

  jdk = pkgs."jdk${jdkVersion}";

  # point gradle to the jdk
  myGradle = pkgs.gradle.override {
    java = jdk;
  };

  # install graal vm for good measure (quarkus)
  graalvm = pkgs."graalvm${jdkVersion}-ce";
in {
  home.sessionVariables = {
    # TODO: dynamisch gestalten (~ funktioniert nicht)
    JAVA_HOME = "/Users/rstauch/jdks/jdk${jdkVersion}";

    GRAALVM_HOME = "${graalvm}";
  };

  home.packages = with pkgs; [
    maven
    myGradle
    jdk
  ];

  home.file."jdks/jdk${jdkVersion}".source = jdk;
}
