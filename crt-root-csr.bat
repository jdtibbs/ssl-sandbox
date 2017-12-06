@echo off
call variables-pw
call variables-ca
call variables-root

SET CN=XXXX-dev.adroot.XXX.com
:GETCN
SET /P ROOT_CN=[Enter full computer name or press enter to accept]%CN%
if "%ROOT_CN%"=="" GOTO GETCN

keytool -genkeypair -alias %ROOT_ALIAS% -dname "CN=%ROOT_CN%, OU=PMC DEV, O=PMC, L=Algona, ST=Iowa, C=US" -keystore %ROOT_STORE% -keypass %PW% -storepass %PW% -storetype JKS -keyalg RSA -validity 9999

echo create a CSR for ROOT.
keytool -certreq -alias %ROOT_ALIAS% -file %ROOT_CSR% -keypass %PW% -storetype JKS -keystore %ROOT_STORE% -storepass %PW%
