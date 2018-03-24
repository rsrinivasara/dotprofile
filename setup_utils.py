#!/usr/bin/env python3

import os
import shutil

def link_verbose(src, dest):
    if os.path.exists(dest) or os.path.islink(dest):
        print('Removing {}'.format(dest))
        if os.path.isfile(dest) or os.path.islink(dest):
            os.remove(dest)
        else:
            shutil.rmtree(dest)

    print('Linking {} -> {}'.format(dest, src))
    os.symlink(src, dest)

def die_if_not_preset(name):
    if not os.path.exists(name):
        print('Cant find {}.  Exiting ...'.format(name))
        sys.exit(1)

def mkdirs_verbose(dir):
    if os.path.exists(dir):
        if not os.path.isdir(dir):
            print('{} is not a directory.  Exiting ...'.format(dir))
            sys.exit(1)
        return

    os.makedirs(dir)

def touch(fname):
    try:
        os.utime(fname, None)
    except OSError:
        open(fname, 'a').close()

def get_proxy_env(http_proxy = None, https_proxy = None):
    proxy_env = os.environ.copy()

    if http_proxy is not None:
        proxy_env['http_proxy'] = http_proxy
    if https_proxy is not None:
        proxy_env['https_proxy'] = https_proxy

    return proxy_env
