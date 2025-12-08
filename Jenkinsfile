pipeline {
  agent any

  environment {
    LIB_VERSION = "2.1.0"
    MAVEN_VERSION = "3.8.6"
    MAVEN_HOME = "/tools/apache-maven-${MAVEN_VERSION}"
    PATH = "${MAVEN_HOME}/bin:$PATH"
  }

  stages {

    stage("Install Maven") {
      steps {
        sh """
          mkdir -p $WORKSPACE/tools
          cd $WORKSPACE/tools
          wget https://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz
          tar -xzf apache-maven-${MAVEN_VERSION}-bin.tar.gz
        """
        sh "mvn -version"
      }
    }

    stage("Clone Shared Lib Repo") {
      steps {
        sh """
          rm -rf nexus-shared-library
          git clone https://github.com/ramtruely/nexus-shared-library.git
        """
      }
    }

    stage("Create Maven Files") {
      steps {
        sh """
          cat > nexus-shared-library/pom.xml <<EOF
<project>
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.roylenferink</groupId>
  <artifactId>jenkins-shared-library</artifactId>
  <version>${LIB_VERSION}</version>
  <packaging>pom</packaging>

  <build>
    <plugins>
      <plugin>
        <artifactId>maven-assembly-plugin</artifactId>
        <version>3.4.2</version>
        <executions>
          <execution>
            <id>make-assembly</id>
            <phase>package</phase>
            <goals>
              <goal>single</goal>
            </goals>
            <configuration>
              <finalName>jenkins-shared-library-${LIB_VERSION}-lib</finalName>
              <descriptors>
                <descriptor>assembly.xml</descriptor>
              </descriptors>
            </configuration>
          </execution>
        </executions>
      </plugin>
    </plugins>
  </build>

</project>
EOF
        """

        sh """
          cat > nexus-shared-library/assembly.xml <<EOF
<assembly
 xmlns="http://maven.apache.org/plugins/maven-assembly-plugin/assembly/1.1.3">
  <id>lib</id>
  <formats><format>zip</format></formats>
  <includeBaseDirectory>false</includeBaseDirectory>
  <fileSets>
    <fileSet>
      <directory>.</directory>
      <outputDirectory>/</outputDirectory>
      <includes>
        <include>src/**</include>
        <include>vars/**</include>
        <include>resources/**</include>
      </includes>
    </fileSet>
  </fileSets>
</assembly>
EOF
        """

        sh """
          cat > /tmp/settings.xml <<EOF
<settings>
  <servers>
    <server>
      <id>nexus-repo</id>
      <username>admin</username>
      <password>admin</password>
    </server>
  </servers>
</settings>
EOF
        """
      }
    }

    stage("Package (ZIP)") {
      steps {
        sh """
          cd nexus-shared-library
          mvn -s /tmp/settings.xml package
        """
      }
    }

    stage("Upload to Nexus") {
      steps {
        sh """
          mvn -s /tmp/settings.xml deploy:deploy-file \
              -DpomFile=temp-pom.xml \
              -Dfile=shared-lib/jenkins-shared-library-2.1.0-lib.zip \
              -Dpackaging=zip \
              -Dclassifier=lib \
              -DrepositoryId=nexus-repo \
              -Durl=http://localhost:8081/repository/maven-shared-lib/
        """
      }
    }
  }    
}
