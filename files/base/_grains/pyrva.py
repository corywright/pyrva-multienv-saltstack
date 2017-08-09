#!/usr/bin/env python

import re
import socket

NODETYPES = {
    'api':         'api',
    'web':         'www',
    'database':    'db'
}

def set_grains_from_hostname(hostname=None):
    if hostname is None:
        hostname = socket.getfqdn()
    
    results = {
        'dc':           'UNKNOWN',
        'nodetype':     'UNKNOWN',
        'nodenumber':   None
    }

    if hostname.startswith("host-"):  # legacy hostnames begin with `host-`
        hostname = hostname.replace("host-", "")
        # ex: nycweb01.example.com
        hnpattern = re.compile("^(?P<datacenter>\w{3})(?P<nodetype>[a-zA-Z\-]*)(?P<nodenumber>[0-9]*)(\.example\.com)?$")
    else:
        # ex: time01.nyc.example.com
        hnpattern = re.compile("^(?P<nodetype>[a-zA-Z\-]*)(?P<nodenumber>[0-9]*)\.(?P<datacenter>\w{3})(\.example\.com)?$")

    hndata = re.match(hnpattern, hostname)
    if hndata:
        dc = hndata.group('datacenter')
        results['dc'] = dc

        # set nodetype
        nodetype = hndata.group('nodetype')
        nodetype_label = NODETYPES.get(nodetype, nodetype)
        results['nodetype'] = nodetype_label

        # set the nodenumber
        nodenumber = hndata.group('nodenumber')
        if nodenumber.isdigit():
            nodenumber = int(nodenumber)
        else:
            nodenumber = None
        results['nodenumber'] = nodenumber

        # define the `role` grain for use with database configuration files
        if results['nodetype'] == 'db':
            if results['nodenumber'] == 1:
                results['role'] = 'master'
            else:
                results['role'] = 'slave'

    return results
