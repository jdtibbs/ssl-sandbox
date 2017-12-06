@echo off

call variables-pw
call variables-ca
call variables-root

echo sign the CSR for ROOT.
keytool -gencert -infile %ROOT_CSR% -outfile %ROOT_CSR_CRT% -alias %CA_ALIAS% -keypass %PW% -keystore %CA_STORE% -storepass %PW% -validity 9999

echo import the CA certificate into ROOT_STORE.
keytool -importcert -file %CA_CERT% -alias %CA_ALIAS% -keypass %PW% -keystore %ROOT_STORE% -storepass %PW%

echo import the CA signed ROOT certificate into ROOT_STORE.
keytool -importcert -file %ROOT_CSR_CRT% -alias %ROOT_ALIAS% -keypass %PW% -keystore %ROOT_STORE% -storepass %PW%

echo delete CSR certificate
del %ROOT_CSR_CRT%

echo print final keystore...
keytool -list -keystore %ROOT_STORE% -storepass %PW%

echo export the ROOT certificate to distribute to clients: %ROOT_CERT%
keytool -export -alias %ROOT_ALIAS% -file %ROOT_CERT% -keypass %PW% -storepass %PW% -keystore %ROOT_STORE% -rfc

echo export the ROOT certificate to distribute to clients: %ROOT_CERT%
keytool -export -alias %ROOT_ALIAS% -file %ROOT_CERT% -keypass %PW% -storepass %PW% -keystore %ROOT_STORE% -rfc
