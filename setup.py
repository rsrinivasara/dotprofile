#!/usr/bin/env python3

import os
import sys
import configparser
import easy_exec
import argparse

def link_verbose(src, dest):
    if os.path.exists(dest) or os.path.islink(dest):
        print('Removing {}'.format(dest))
        os.remove(dest)

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

class UserEnv(object):
    """
    [proxy]
    (optional) http_proxy =
    (optional) https_proxy =

    [paths]
    dotprofile =
    python2 =
    python3 =
    venv_exec =
    python2_venv =
    nvim_venv_python2 =
    nvim_venv_python3 =
    (optional) cert =
    zsh =
    """
    def __init__(self):
        self.home_dir = os.environ['HOME']
        self._dev_config_file = os.path.join(self.home_dir, '.dev_config')

        cfg = configparser.ConfigParser()
        cfg.optionxform = str
        cfg.read(self._dev_config_file)

        # Proxy is optional
        self.https_proxy = None
        self.http_proxy = None
        if cfg.has_section('proxy'):
            self.http_proxy = cfg.get('proxy', 'http_proxy')
            self.https_proxy = cfg.get('proxy', 'https_proxy')

        self.dotprofile_dir = cfg.get('paths', 'dotprofile')
        die_if_not_preset(self.dotprofile_dir)

        self.python2 = cfg.get('paths', 'python2')
        die_if_not_preset(self.dotprofile_dir)

        self.python3 = cfg.get('paths', 'python3')
        die_if_not_preset(self.python3)

        self.venv_exec = cfg.get('paths', 'venv_exec')
        die_if_not_preset(self.venv_exec)

        self.python2_venv = cfg.get('paths', 'python2_venv')
        mkdirs_verbose(self.python2_venv)

        self.python3_venv = cfg.get('paths', 'python3_venv')
        mkdirs_verbose(self.python3_venv)

        self.nvim_venv_python2 = cfg.get('paths', 'nvim_venv_python2')
        mkdirs_verbose(self.nvim_venv_python2)

        self.nvim_venv_python3 = cfg.get('paths', 'nvim_venv_python3')
        mkdirs_verbose(self.nvim_venv_python3)

        self.cert = None
        if cfg.has_option('paths', 'cert'):
            self.cert = cfg.get('paths', 'cert')

        self.zsh = cfg.get('paths', 'zsh')
        die_if_not_preset(self.zsh)

    def use_proxy(self):
        return self.http_proxy is not None or self.https_proxy is not None

    def get_proxy_env(self):
        proxy_env = None
        if self.use_proxy():
            proxy_env = os.environ.copy()
            if self.http_proxy is not None:
                proxy_env['http_proxy'] = self.http_proxy
            if self.https_proxy is not None:
                proxy_env['https_proxy'] = self.https_proxy

        return proxy_env

class PythonVenvCreator(object):
    def __init__(self, user_env, venv_path, python_exec):
        self.user_env = user_env
        self.venv_path = venv_path
        self.python_exec = python_exec

    def create(self):
        if not os.path.exists(self.venv_path):
            print('Creating venv {} ...'.format(self.venv_path))
            mkdirs_verbose(self.venv_path)
            create_venv_cmd = [ self.user_env.venv_exec,
                                self.venv_path,
                                '-p', self.python_exec ]
            easy_exec.exec_command(create_venv_cmd)

        cmd_env = self.user_env.get_proxy_env()

        # Upgrade pip
        print('Upgrading pip ...')
        pip_exec = os.path.join(self.venv_path, 'bin', 'pip')
        upgrade_pip_cmd = [ pip_exec,
                            'install', '--upgrade', 'pip' ]
        if self.user_env.cert is not None:
            upgrade_pip_cmd.extend(['--cert', self.user_env.cert])
        easy_exec.exec_command(upgrade_pip_cmd, env=cmd_env)

    def install_packages(self, packages):
        die_if_not_preset(self.venv_path)

        print('Installing {} ...'.format(' '.join(packages)))
        install_cmd = [ pip_exec, 'install' ] + packages
        if self.user_env.cert is not None:
            install_cmd.extend(['--cert', self.user_env.cert])
        easy_exec.exec_command(install_cmd, env=cmd_env)

class NeovimEnv(object):
    def __init__(self, user_env):
        self.user_env = user_env

        self.nvim_link = os.path.join(self.user_env.home_dir, '.nvim')
        self.nvim_dir = os.path.join(self.user_env.dotprofile_dir, 'nvim')

        self.share_dir = os.path.join(self.user_env.home_dir, '.local', 'share')

        self.nvim_share_dir = os.path.join(self.share_dir, 'nvim')

        self.nvim_config_dir = os.path.join(self.user_env.home_dir, '.config', 'nvim')

    def _setup_venv(self, venv_path, python_exec):
        # Create venv
        venv_creator = PythonVenvCreator(self.user_env, venv_path, python_exec)
        venv_creator.create()
        venv_creator.install_packages(['neovim', 'jedi'])

    def _setup_venvs(self):
        # Python2
        self._setup_venv(self.user_env.nvim_venv_python2, self.user_env.python2)

        # Python3
        self._setup_venv(self.user_env.nvim_venv_python3, self.user_env.python3)

    def _setup_dirs(self):
        link_verbose(self.nvim_dir, self.nvim_link)

        mkdirs_verbose(self.share_dir)

        link_verbose(self.nvim_dir, self.nvim_share_dir)

        mkdirs_verbose(self.nvim_config_dir)

    def _create_init_vim(self):
        init_vim_file = os.path.join(self.nvim_config_dir, 'init.vim')
        with open(init_vim_file, 'w') as f:
            f.write('let g:python_host_prog="{}"\n'.format(
                        os.path.join(self.user_env.nvim_venv_python2, 'bin', 'python')))
            f.write('let g:python3_host_prog="{}"\n'.format(
                        os.path.join(self.user_env.nvim_venv_python3, 'bin', 'python3')))
            f.write('source {}\n'.format(os.path.join(self.nvim_link, 'init.vim')))

    def _setup_vim_plugged(self):
        print('Setting up vimplug ..')
        vim_plug_file = os.path.join(self.nvim_share_dir,
                                     'site', 'autoload', 'plug.vim')
        cmd_env = self.user_env.get_proxy_env()

        cmd = [ 'curl', '-fLo', vim_plug_file, '--create-dirs',
                'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' ]

        if self.user_env.cert is not None:
            cmd.extend(['--cacert', self.user_env.cert])
        easy_exec.exec_command(cmd, env=cmd_env)

    def setup(self):
        print('Setting up neovim ...')
        self._setup_venvs()
        self._setup_dirs()
        self._create_init_vim()
        self._setup_vim_plugged()
        print('Done')


class TmuxEnv(object):
    def __init__(self, user_env):
        self.user_env = user_env
        self.tmux_conf = os.path.join(self.user_env.dotprofile_dir,
                'tmux.conf')

        self.tmux_conf_link = os.path.join(self.user_env.home_dir,
                '.tmux.conf')

    def setup(self):
        die_if_not_preset(self.tmux_conf)
        link_verbose(self.tmux_conf, self.tmux_conf_link)

class ZshEnv(object):
    def __init__(self, user_env):
        self.user_env = user_env
        self.zsh_conf = os.path.join(self.user_env.dotprofile_dir, 'zshrc')
        self.zsh_conf_link = os.path.join(self.user_env.home_dir, '.zshrc')

    def setup(self):
        die_if_not_preset(self.zsh_conf)

        with open(self.zsh_conf_link, 'w') as f:
            f.write('ZSH_TMUX_TERM={}\n'.format(self.user_env.zsh))
            f.write('source {}\n'.format(self.zsh_conf))

def add_yesno_argument(parser, optname):
    parser.add_argument(
        '--{}'.format(optname), dest=optname, action='store_true',
        default=True, help='Configure {}'.format(optname))
    parser.add_argument(
        '--no_{}'.format(optname), dest=optname, action='store_false',
        default=False, help='Don\'t configure {}'.format(optname))

class PythonVenv(object):
    def __init__(self, user_env):
        self.user_env = user_env

    def setup(self):
        venv_creator = PythonVenvCreator(self.user_env,
                                         self.user_env.python3_venv,
                                         self.user_env.python3)
        venv_creator.create()
        venv_creator.install_packages(['numpy', 'pandas'])

def main():
    parser = argparse.ArgumentParser(description='Setup user profile')
    add_yesno_argument(parser, 'neovim')
    add_yesno_argument(parser, 'tmux')
    add_yesno_argument(parser, 'zsh')
    add_yesno_argument(parser, 'python_venv')

    args = parser.parse_args()
    print(args)

    # user_env = UserEnv()
    # print('Using {} as dotprofile dir'.format(user_env.dotprofile_dir))

    # nvim_env = NeovimEnv(user_env)
    # nvim_env.setup()

if __name__ == "__main__":
    main()



