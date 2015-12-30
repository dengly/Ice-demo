#!/bin/bash
#
# 作者：邓燎燕
# 2015-12-25
# 
# 要配置好iceca的ICE_CA_HOME环境变量
# 我的ca、server和client密码都是123456

echo "------------ iceca init --------------"
iceca init

echo "------------ iceca create server and client --------------"
iceca create --ip=192.168.0.112 --dns=192.168.0.112 server

iceca create client

echo "------------ iceca export cert --------------"
iceca export --password 123456 --alias ca ./ca/ca.cer
iceca export --password 123456 --alias client ./ca/client.cer
iceca export --password 123456 --alias server ./ca/server.cer

echo "------------ iceca export jks --------------"
iceca export --password 123456 --alias ca ./ca/ca.jks
iceca export --password 123456 --alias client ./ca/client.jks
iceca export --password 123456 --alias server ./ca/server.jks

echo "------------ iceca export bks --------------"
iceca export --password 123456 --alias ca ./ca/ca.bks
iceca export --password 123456 --alias client ./ca/client.bks
iceca export --password 123456 --alias server ./ca/server.bks

echo "------------ iceca export p12 --------------"
iceca export --password 123456 --alias ca ./ca/ca.p12
iceca export --password 123456 --alias client ./ca/client.p12
iceca export --password 123456 --alias server ./ca/server.p12

echo "------------ keytool -import --------------"
keytool -import -v -trustcacerts -alias ca -file ./ca/ca.cer -storepass 123456 -keystore ./ca/server.jks
keytool -import -v -trustcacerts -alias ca -file ./ca/ca.cer -storepass 123456 -keystore ./ca/client.jks

keytool -import -v -trustcacerts -alias ca -file ./ca/ca.cer -storepass 123456 -keystore ./ca/server.bks -storetype bks -provider org.bouncycastle.jce.provider.BouncyCastleProvider -providerpath /path/bcprov-jdk15on-153.jar
keytool -import -v -trustcacerts -alias ca -file ./ca/ca.cer -storepass 123456 -keystore ./ca/client.bks -storetype bks -provider org.bouncycastle.jce.provider.BouncyCastleProvider -providerpath /path/bcprov-jdk15on-153.jar

echo "--------------------------"
keytool -list -keystore ./ca/ca.p12 -storetype pkcs12 -v -storepass 123456
echo "--------------------------"
keytool -list -keystore ./ca/ca.jks -storepass 123456 -v
echo "--------------------------"
keytool -list -keystore ./ca/ca.bks -storetype bks -storepass 123456 -v -provider org.bouncycastle.jce.provider.BouncyCastleProvider -providerpath /path/bcprov-jdk15on-153.jar
echo "--------------------------"
keytool -list -keystore ./ca/server.p12 -storetype pkcs12 -v -storepass 123456
echo "--------------------------"
keytool -list -keystore ./ca/server.jks -storepass 123456 -v
echo "--------------------------"
keytool -list -keystore ./ca/server.bks -storetype bks -storepass 123456 -v -provider org.bouncycastle.jce.provider.BouncyCastleProvider -providerpath /path/bcprov-jdk15on-153.jar
echo "--------------------------"
keytool -list -keystore ./ca/client.p12 -storetype pkcs12 -v -storepass 123456
echo "--------------------------"
keytool -list -keystore ./ca/client.jks -storepass 123456 -v
echo "--------------------------"
keytool -list -keystore ./ca/client.bks -storepass 123456 -v -storetype bks -provider org.bouncycastle.jce.provider.BouncyCastleProvider -providerpath /path/bcprov-jdk15on-153.jar

echo ""
echo ""
echo "--------------------------"
echo "配置说明"
echo "Glacier2的配置IceSSL.CAs=ca.pem，IceSSL.CertFile=server.p12"
echo "纯Java客户端使用client.jks"
echo "Android客户端使用client.bks"
echo "iOS客户端使用ca.cer和client.p12，IceSSL.CAs=ca.cer，IceSSL.CertFile=client.p12"
echo ""
