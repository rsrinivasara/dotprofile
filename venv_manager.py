#!/usr/bin/env python3

import argparse
import os
import re
import shutil

import easy_exec
import setup_utils

# This does not work for python3 as python3-virtualenv is depricated.
# See https://docs.python.org/3/library/venv.html
class VenvManager(object):
    def __init__(self, venv_path, python_exec = 'python',
                 venv_exec = 'virtualenv', http_proxy = None,
                 https_proxy = None, cert = None):
        self.venv_path = venv_path
        self.python_exec = python_exec
        self.venv_exec = venv_exec
        self.cert = cert

        self.pip_exec = os.path.join(self.venv_path, 'bin', 'pip')
        self.cmd_env = setup_utils.get_proxy_env(http_proxy, https_proxy)

    def _get_python_version(self, python_exec):
        try:
            lines = easy_exec.exec_command([python_exec, '--version'])
        except easy_exec.ExecutionError:
            print('Cant get version of {}'.format(python_exec))
            return 0

        reg = re.compile(b'Python (\d*)\.(\d*)\.(\d*)')
        m = reg.match(lines)
        if m:
            return int(m.group(1))

        return 0

    def create(self):
        created_file = os.path.join(self.venv_path, '.created')

        if not os.path.exists(created_file):
            print('Creating venv {} ...'.format(self.venv_path))
            setup_utils.mkdirs_verbose(self.venv_path)
            if self._get_python_version(self.python_exec) == 3:
                create_venv_cmd = [ self.python_exec, '-m', 'venv',
                                    self.venv_path ]
            else:
                create_venv_cmd = [ self.venv_exec,
                                    self.venv_path,
                                    '-p', self.python_exec ]

            easy_exec.exec_command(create_venv_cmd)

            setup_utils.touch(created_file)
        else:
            print('{} already exists'.format(self.venv_path))

        # Upgrade pip
        print('Upgrading pip ...')
        upgrade_pip_cmd = [ self.pip_exec,
                            'install', '--upgrade', 'pip' ]
        if self.cert is not None:
            upgrade_pip_cmd.extend(['--cert', self.cert])
        easy_exec.exec_command(upgrade_pip_cmd, env=self.cmd_env)

    def install_packages(self, packages):
        setup_utils.die_if_not_preset(self.venv_path)

        print('Installing {} ...'.format(' '.join(packages)))
        install_cmd = [ self.pip_exec, 'install' ] + packages
        if self.cert is not None:
            install_cmd.extend(['--cert', self.cert])
        easy_exec.exec_command(install_cmd, env=self.cmd_env)

    def update_packages(self, packages):
        print('Updating packages not implemented yet')

    def delete(self):
        print('Removing {} ...'.format(self.venv_path))
        shutil.rmtree(self.venv_path)

def main():
    parser = argparse.ArgumentParser(description='Manage virtualenv')
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument('-c','--create', action='store_true',
                       help='Create virtualenv')
    group.add_argument('-u','--update', action='store_true',
                       help='Update packages in virtualenv')
    group.add_argument('-d','--delete', action='store_true',
                       help='Delete virtualenv')
    parser.add_argument('-p','--packages', nargs='*',
                        help='List of packages to install')
    parser.add_argument('venv_path', nargs=1)

    args = parser.parse_args()

    venv_manager = VenvManager(args.venv_path[0])
    if args.create:
        venv_manager.create()

        if args.packages is not None:
            venv_manager.install_packages(args.packages)

    if args.update:
        venv_manager.update_packages(args.packages)

    if args.delete:
        venv_manager.delete()

if __name__ == "__main__":
    main()
