#!/bin/bash
set -e

# 1) Lee la versión
VERSION=$(cat VERSION)

# 2) Limpia y crea carpeta de compilación
rm -rf build
mkdir -p build/WEB-INF/classes

# 3) Compila tu código
find src -name "*.java" > sources.txt
javac -classpath "/c/xampp/tomcat/lib/servlet-api.jar" \
      -d build/WEB-INF/classes @sources.txt

# 4) Copia recursos web (JSP, web.xml, etc.)
cp -r WebContent/* build/

# 5) Empaqueta el WAR
cd build
jar cvf ../CRAFTOPIA.war *
cd ..

echo "✅ WAR generado: CRAFTOPIA.war (v$VERSION)"

# 6) Copia el WAR a releases con versión
mkdir -p /c/xampp/releases
cp CRAFTOPIA.war /c/xampp/releases/CRAFTOPIA-v${VERSION}.war

echo "✅ Release creado: C:/xampp/releases/CRAFTOPIA-v${VERSION}.war"
