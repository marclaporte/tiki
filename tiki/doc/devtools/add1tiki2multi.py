#!/usr/bin/env python

# $Header: /cvsroot/tikiwiki/tiki/doc/devtools/add1tiki2multi.py,v 1.3 2004-04-24 05:30:40 ggeller Exp $

# Copyright (c) 2004 George G. Geller
# All Rights Reserved. See copyright.txt for details and a complete list of au\thors.
# Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for de\tails.

# invoke as sudo ./clikitiki.py <mysql-root-password> <new-tiki-url>

# NOTICE:
# 1. This script is intended to be run as root.
# 2. A lot of optional features must be set to particular values before this script can work.
#    For background material see:
#     http://tikiwiki.org/tiki-index.php?page=RecipeMultiTiki
#     http://tikiwiki.org/tiki-index.php?page=RecipeMultiTiki2
# 3. You must edit this script before it can run (see below).

import os
import sys
import re


# YOU MUST COMMENT OUT THE FOLLOWING LINE FOR THIS SCRIPT TO FUNCTION!!!!
# THIS SCRIPT IS DISABLED BY DEFAULT TO MINIMIZE THE SECURITY RISK FOR NAIVE TIKI ADMINS!
# sys.exit(0)

# Invoke as something like: ./newTiki.py password new.wikiplanet.com

sMySQLPassword = sys.argv[1]

sNewDomain = sys.argv[2]
sNewDomain = sNewDomain.lower()

# This script must be run as root
if os.getuid():
    print sys.argv[0], "must be run as root."
    sys.exit(-1)

# sNewDomain has to look like new.wikiplanet.com
# check for two "."
if sNewDomain.count(".") != 2:
    print sys.argv[0]+":", "Your new domain name must contain two \".\" characters. Exiting."
    sys.exit(-1)

# check for length
if len(sNewDomain) > 80:
    print sys.argv[0]+":", "Your new domain name is too long. Exiting."
    sys.exit(-1)

# check for illegal characters
if re.search(r'[^-.a-z0-9]',sNewDomain):
    print sys.argv[0]+":", "Your new domain name has illegal characters. Exiting."
    sys.exit(-1)

# must start with a letter
if not re.search(r'^[a-z].+',sNewDomain):
    print sys.argv[0]+":", "Your new domain name must start a letter. Exiting."
    sys.exit(-1)

# must end with a letter
if not re.search(r'[a-z]$',sNewDomain):
    print sys.argv[0]+":", "Your new domain name must end with a letter. Exiting."
    sys.exit(-1)

# check for /www
status = os.system("ls /www > /dev/null 2>&1")
if status:
    print sys.argv[0]+":", "ls /www failed.  Exiting."
    sys.exit(status)

# check for sNewDomain already in /www
status = os.system("ls /www/" + sNewDomain + " > /dev/null 2>&1")
if status == 0:
    print sys.argv[0]+":", "file /www/" + sNewDomain + " already exists.  Exiting."
    sys.exit(status)

# sPrefix should be someting like new from new.wikiplanet.com
sPrefix = sNewDomain[0:sNewDomain.find(".")]

# check for illegal characters
if re.search(r'[^-a-z0-9]',sPrefix):
    print sys.argv[0]+":", "Your new domain prefix name has illegal characters. Exiting."
    sys.exit(-1)

sDBName = "tiki_"+sPrefix
# check to see if the database exists

sTmpOutFileName = "/tmp/clikitiki-"+str(os.getpid())+".out"
sTmpErrFileName = "/tmp/clikitiki-"+str(os.getpid())+".err"
status = os.system("mysqlshow -uroot -p" + sMySQLPassword  + " > "+sTmpOutFileName+" 2>"+sTmpErrFileName)
if status:
    os.system("rm -f " + sTmpOutFileName + " " + sTmpErrFileName)
    print sys.argv[0]+":", "mysqlshow failed.  Maybe you used the wrong mysql root password? Exiting."
    sys.exit(status)

os.system("rm -f " + sTmpErrFileName)

# The output from mysqlshow in should look something like this:
# +--------------+
# | Databases    |
# +--------------+
# | mysql        |
# | test         |
# | tiki_members |
# | tiki_public  |
# | tiki_staff   |
# +--------------+

f = open(sTmpOutFileName,"r")
lines = f.readlines()
f.close()
os.system("rm -f " + sTmpOutFileName)

# print lines

pat0 = re.compile("\s([_a-z]+)\s")
for line in lines:
    match = pat0.search(line)
    if match:
#        print match.start(), match.end(), match.group(1)
        if match.group(1) == sDBName:
            print sys.argv[0]+":", "There is already a database named " + sDBName +". Exiting."
            sys.exit(-1)

# check for /etc
status = os.system("ls /etc > /dev/null 2>&1")
if status:
    print sys.argv[0]+":", "ls /etc failed.  Exiting."
    sys.exit(status)

# check for /etc/httpd
status = os.system("ls /etc/httpd > /dev/null 2>&1")
if status:
    print sys.argv[0]+":", "ls /etc/httpd failed.  Exiting."
    sys.exit(status)

# check for /etc/httpd/conf.d
status = os.system("ls /etc/httpd/conf.d > /dev/null 2>&1")
if status:
    print sys.argv[0]+":", "ls /etc/httpd/conf.d failed.  Exiting."
    sys.exit(status)

#
# Check for something like /etc/httd/conf.d/new.wikiplanet.com.vh
#
sVHFileName = "/etc/httpd/conf.d/" + sNewDomain + ".vh"
status = os.system("ls " + sVHFileName + " > /dev/null 2>&1")
if status == 0:
    print sys.argv[0]+":", "file " + sVHFileName + " already exists.  Exiting."
    sys.exit(status)

#
# Check for Include /etc/httpd/conf.d/*.vh in /etc/httpd/conf/httpd.conf
#
f = open("/etc/httpd/conf/httpd.conf","r")
lines = f.readlines()
f.close()
bFound = False
for line in lines:
    if line == "Include conf.d/*.vh\n":
        bFound = True
        break

if not bFound:
    print sys.argv[0]+":", "Could not find Include conf.d/*.vh in /etc/httpd/conf/httpd.conf.  Exiting."
    sys.exit(-1)

#
# Check db/local.php
#
f = open("/www/tikiwiki/db/local.php","r")
lines = f.readlines()
f.close

# look for the last else
last = 0;
for i in range (0, len(lines)):
    if lines[i].find("else") != -1:
        last = i
if last == 0:
    print sys.argv[0]+":", "Your db/local.php is not in the expected format.  Exiting."
    sys.exit(-1)

# Look for sDomainName in local.php
found = False
for i in range (0, len(lines)):
    if lines[i].find("sDomainName") != -1:
        found = True
if found:
    print sys.argv[0]+":", sDomainName, "is aleady defined in db/local.php.  Exiting."
    sys.exit(-1)

#
# So far, we have not done anything except check the input and the state of the
#  system.  Now it is time to:
#  1. Create the new database
#  2. Add the right mysql permission to the database
#  3. Load the database from tikiwiki/db/tiki.sql
#  4. Create the new symbolic link in /www
#  5. Create the new directories in /www/tikiwiki
#  6. Create the .vh file in /etc/httpd/conf.d
#  7. Modify db/local.php
#  8. Restart apache

# The data we already have:
#  sMySQLPassword  - the root password for mysql, something like "password"
#  sNewDomain      - the name of the new domain, something like "new.wikiplanet.com"
#  sPrefix         - the prefix of the new domain, something like "new"
#  sDBName         - the name of the new database, something like "tiki_new"
#  sTmpOutFileName - a temp file name, something like "/tmp/clickitiki-1234.out"
#  sTmpErrFileName - a temp file name, something like "/tmp/clickitiki-1234.err"
#  sVHFileName     - new .vh file, something like "/etc/httd/conf.d/new.wikiplanet.com.vh"

#  1. Create the new database
sCommand = "mysqladmin -uroot -p" + sMySQLPassword + " create " + sDBName
status = os.system(sCommand)
if status:
    print sys.argv[0]+":", sCommand, "failed.  Exiting."
    sys.exit(status)

#  2. Add the right mysql permission to the database
f = open(sTmpOutFileName, "w")
f.write("""GRANT ALL PRIVILEGES ON `"""+sDBName+"""` . * TO "tiki"@"localhost";\n""")
f.write("""REVOKE GRANT OPTION ON `"""+sDBName+"""` . * FROM "tiki"@"localhost";\n""")
f.close()
sCommand = "mysql -uroot mysql -p" + sMySQLPassword + "< " + sTmpOutFileName
status = os.system(sCommand)
if status:
    print sys.argv[0]+":", sCommand, "failed.  Exiting."
    sys.exit(status)
os.system("rm -f " + sTmpOutFileName)

#  3. Load the database from tikiwiki/db/tiki.sql
sCommand = "mysql -uroot -p" + sMySQLPassword + " "  + sDBName + " < /www/tikiwiki/db/tiki.sql"
status = os.system(sCommand)
if status:
    print sys.argv[0]+":", sCommand, "failed.  Exiting."
    sys.exit(status)

#  4. Create the new symbolic link in /www
os.chdir("/www")
sCommand = "ln -s tikiwiki " + sNewDomain
status = os.system(sCommand)
if status:
    print sys.argv[0]+":", sCommand, "failed.  Exiting."
    sys.exit(status)
os.chdir("/www/tikiwiki")

#  5. Create the new directories in /www/tikiwiki
sApacheGID = sApacheUID = 48 # FIXME This need to be generalized
# FIXME The following lines need error checking
# FIXME Should maybe set the permission on the new directories
os.mkdir("./backups/" + sNewDomain)
os.chown("./backups/" + sNewDomain, sApacheUID, sApacheGID)
os.mkdir("./db/" + sNewDomain)
os.chown("./db/" + sNewDomain, sApacheUID, sApacheGID)
os.mkdir("./dump/" + sNewDomain)
os.chown("./dump/" + sNewDomain, sApacheUID, sApacheGID)
os.mkdir("./img/wiki/" + sNewDomain)
os.chown("./img/wiki/" + sNewDomain, sApacheUID, sApacheGID)
os.mkdir("./img/wiki_up/" + sNewDomain)
os.chown("./img/wiki_up/" + sNewDomain, sApacheUID, sApacheGID)
os.mkdir("./lib/Galaxia/processes/" + sNewDomain)
os.chown("./lib/Galaxia/processes/" + sNewDomain, sApacheUID, sApacheGID)
os.mkdir("./modules/cache/" + sNewDomain)
os.chown("./modules/cache/" + sNewDomain, sApacheUID, sApacheGID)
os.mkdir("./styles/" + sNewDomain)
os.chown("./styles/" + sNewDomain, sApacheUID, sApacheGID)
os.mkdir("./temp/" + sNewDomain)
os.chown("./temp/" + sNewDomain, sApacheUID, sApacheGID)
os.mkdir("./temp/cache/" + sNewDomain)
os.chown("./temp/cache/" + sNewDomain, sApacheUID, sApacheGID)
os.mkdir("./templates/" + sNewDomain)
os.chown("./templates/" + sNewDomain, sApacheUID, sApacheGID)
os.mkdir("./templates_c/" + sNewDomain)
os.chown("./templates_c/" + sNewDomain, sApacheUID, sApacheGID)
os.mkdir("./var/" + sNewDomain)
os.chown("./var/" + sNewDomain, sApacheUID, sApacheGID)
os.mkdir("./var/log/" + sNewDomain)
os.chown("./var/log/" + sNewDomain, sApacheUID, sApacheGID)
os.mkdir("./var/log/irc/" + sNewDomain)
os.chown("./var/log/irc/" + sNewDomain, sApacheUID, sApacheGID)

#  6. Create the .vh file in /etc/httpd/conf.d
sDomainLastPart = sNewDomain[sNewDomain.find(".")+1:] # something like "wikiplanet.com"

f = open(sVHFileName, "w");
# These need to be generalized
f.write("<VirtualHost *:80>\n");
f.write("  ServerAdmin webmaster@" + sDomainLastPart + "\n");
f.write("  DocumentRoot /www/" + sNewDomain + "\n");
f.write("  ServerName " + sNewDomain + "\n");
f.write("  ErrorLog logs/" + sNewDomain + "-error_log\n");
f.write("  CustomLog logs/" + sNewDomain + "-access_log common\n");
f.write("</VirtualHost>\n");
f.close();

#  7. Modify db/local.php
# insert three lines at the correct place

f = open("/www/tikiwiki/db/local.php","r")
lines = f.readlines()
f.close

for i in range (0, len(lines)):
    if lines[i].find("else") != -1:
        last = i

lout = []
for i in range (0, last):
    lout.append(lines[i])

lout.append("""} else if ($_SERVER["HTTP_HOST"] == \"""" + sNewDomain + """\") {\n""")
lout.append("""  $dbs_tiki   = \"""" + sDBName    + """\";\n""")
lout.append("""  $tikidomain = \"""" + sNewDomain + """\";\n""")
  
for i in range (last, len(lines)):
    lout.append(lines[i])

f = open("db/local.php","w")
f.writelines(lout)
f.close

#  8. Restart apache
os.system("/usr/sbin/apachectl graceful")
