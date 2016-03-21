#!/usr/bin/python
import sys
import os
import logging
logging.basicConfig(stream=sys.stderr)
sys.path.insert(0,"/var/www/html/")

#os.chdir(r"/var/www/Porfolio/")
from app import app as application
application.secret_key = 'portfolio'