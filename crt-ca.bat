@echo off

call variables-pw
call variables-ca

echo create a self signed CA key pair.
keytool -genkeypair -alias %CA_ALIAS% -dname "CN=XXXXX, OU=XXX DEV, O=XXX, L=XXX, ST=Iowa, C=US" -keystore %CA_STORE% -keypass %PW% -storepass %PW% -storetype JKS -keyalg RSA -ext KeyUsage="keyCertSign" -ext BasicConstraints:"critical=ca:true" -validity 9999

echo export the CA public certificate so that it can be used in trust stores.
keytool -export -alias %CA_ALIAS% -file %CA_CERT% -keypass %PW% -storepass %PW% -keystore %CA_STORE% -rfc

:IMPORT
SET /P A=[Now import %CA_CERT% into your Trusted Root Certification Authorities. Are you done? y/n]
if not "%A%"=="y" GOTO IMPORT
