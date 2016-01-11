#!/usr/bin/env python
# **********************************************************************
#
# Copyright (c) 2003-2015 ZeroC, Inc. All rights reserved.
# 
# modify by sk163
#
# **********************************************************************

import os, sys, socket, getopt,getpass

try:
    import IceCertUtils
except:
    print("error: couldn't find IceCertUtils, install `zeroc-icecertutils' package "
          "from Python package repository")
    sys.exit(1)
    
def question(message, expected = None):
   sys.stdout.write(message)
   sys.stdout.write(' ')
   sys.stdout.flush()
   choice = sys.stdin.readline().strip()
   if expected:
      return choice in expected
   else:
      return choice
      
   
def usage():
    print("Usage: " + sys.argv[0] + " [options]")
    print("")
    print("Options:")
    print("-h               Show this message.")
    print("-d | --debug     Debugging output.")
    print("--ip <ip>        The IP address for the server certificate.")
    print("--dns <dns>      The DNS name for the server certificate.")
    print("--use-dns        Use the DNS name for the server certificate common")
    print("                 name (default is to use the IP address)." )
    sys.exit(1)

#
# Check arguments
#
debug = False
ip = None
dns = None
usedns = False
impl = ""
createCA=False
try:
    opts, args = getopt.getopt(sys.argv[1:], "hd", ["help", "debug", "ip=", "dns=","use-dns","impl="])
except getopt.GetoptError as e:
    print("Error %s " % e)
    usage()
    sys.exit(1)

for (o, a) in opts:
    if o == "-h" or o == "--help":
        usage()
        sys.exit(0)
    elif o == "-d" or o == "--debug":
        debug = True
    elif o == "--ip":
        ip = a
    elif o == "--dns":
        dns = a
    elif o == "--use-dns":
        usedns = True
    elif o == "--impl":
        impl = a

def request(question, newvalue, value):
    while True:
        sys.stdout.write(question)
        sys.stdout.flush()
        input = sys.stdin.readline().strip()
        if input == 'n':
            sys.stdout.write(newvalue)
            sys.stdout.flush()
            return sys.stdin.readline().strip()
        else:
            return value

home = os.getcwd()
print home

if question("create CA? (y/n) [n]", ['y', 'Y']):
	if not ip:
	    try:
	        #ip = socket.gethostbyname(socket.gethostname())
	        ip = "127.0.0.1"
	    except:
	        ip = "127.0.0.1"
	    ip = request("The IP address used for the server certificate will be: " + ip + "\n"
	                 "Do you want to keep this IP address? (y/n) [y]", "IP : ", ip)
	
	if not dns:
	    dns = "localhost"
	    dns = request("The DNS name used for the server certificate will be: " + dns + "\n"
	                  "Do you want to keep this DNS name? (y/n) [y]", "DNS : ", dns)
	
	CertificateFactory = vars(IceCertUtils)[impl + "CertificateFactory"]
	# Construct the DN for the CA certificate.
	DNelements = {
	  'C': "Country name",
	  'ST':"State or province name",
	  'L': "Locality",
	  'O': "Organization name",
	  'OU':"Organizational unit name",
	  'CN':"Common name",
	  'emailAddress': "Email address"
	}
	
	dn = IceCertUtils.DistinguishedName("Ice CertUtils CA")
	while True:
	  print("")
	  print("The subject name for your CA will be " + str(dn))
	  print("")
	  if question("Do you want to keep this as the CA subject name? (y/n) [y]", ['n', 'N']):
	     for k,v in DNelements.items():
	        v = question(v + ": ")
	        if k == 'C' and len(v) > 2:
	           print("The contry code can't be longer than 2 characters")
	           continue
	        setattr(dn, k, v)
	
	  else:
	     break
	
	#factory = CertificateFactory(debug=debug, cn="Ice Demos CA")
	capass = getpass.getpass("Enter the CA passphrase:")
	home = os.path.normpath(home)
	factory =lambda: IceCertUtils.CertificateFactory(home=home, debug=debug, dn=dn, password=capass)
	

else:
	
	#ca_path=question("ca.pem follder path:");
	if not os.path.exists(home+"/ca.pem"):
			print("ca.pem not found");
			sys.exit(1)
	capass = getpass.getpass("Enter the CA passphrase:")
	factory =lambda: IceCertUtils.CertificateFactory(home=home, debug=debug, password=capass)
	
# Client certificate
if question("create Client Cert? (y/n) [n]", ['y', 'Y']):
	client_alias=question("client_alias:");
	clinetpass = getpass.getpass("Enter the Client pass passphrase:")
	client = factory().create(client_alias)
	client.save(client_alias+".p12",password=clinetpass).save(client_alias+".jks", caalias="ca",password=clinetpass)

# Server certificate
if question("create Server Cert? (y/n) [n]", ['y', 'Y']):
	server_alias=question("server_alias:");
	serverpass = getpass.getpass("Enter the Server pass passphrase:")
	server = factory().create("server", cn = (dns if usedns else ip), ip=ip, dns=dns)
	server.save("server.p12",password=serverpass).save("server.jks", caalias="ca",password=serverpass)

#try:
#    client.save("client.bks", caalias="cacert")
#    server.save("server.bks", caalias="cacert")
#except Exception as ex:
#    print("warning: couldn't generate BKS certificates:\n" + str(ex))

#factory.destroy()
