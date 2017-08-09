#!/usr/bin/env python

def conf(key, default=''):
    """
    If a pillar variable has a subkey matching the oscodename for the current minion,
    then this function will choose that instead. For example, in this case:

        salt_version: 2014.7.5+ds-1trusty1

    A call to `pyrva.conf('salt_version')` will always return '2014.7.5+ds-1trusty1'

    But if the pillar is structured hierarchically then cbs.conf will choose the
    value for the subkey that matches the minions oscodename:

        salt_version:
          precise: 2014.7.5+ds-1precise1
          trusty: 2014.7.5+ds-1trusty1

    This function also allows us to stop using the long salt['pillar.get']('key:two')
    style way of selecting pillar values. cbs.conf('key:two') works for that as well.
    """

    default_opts_pillar_raise_on_missing = __opts__.get('pillar_raise_on_missing')
    __opts__['pillar_raise_on_missing'] = True

    oscodename = __grains__.get('oscodename')
    key_oscodename = ':'.join([key, oscodename]) # salt_version:trusty
    try:
        value = __salt__['pillar.get'](key_oscodename)
    except KeyError:
        value = __salt__['pillar.get'](key, default)

    __opts__['pillar_raise_on_missing'] = default_opts_pillar_raise_on_missing
    return value


def route_remove(ip, netmask):
    """
    A utility for quickly removing routes nodes:

    ex:
        salt -N storage pyrva.route_remove 10.9.48.0 255.255.240.0
    """
    device = __salt__['pillar.get']('servicenet:interface', 'eth2')
    gateway = __salt__['pillar.get']('network:snet:gateway','not-set')
    # /sbin/route del -net 10.9.48.0 netmask 255.255.240.0 gw 10.190.128.1 dev eth2 || true
    route_remove_cmd = ['/sbin/route', 'del', '-net', ip, 'netmask', netmask, 'gw', gateway, 'dev', device]
    route_remove_output = __salt__['cmd.run'](route_remove_cmd, python_shell=False)
    return route_remove_output
