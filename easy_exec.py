#!/usr/bin/env python

import os
import subprocess

def debug_mode():
    return 'DEBUG_SETUP' in os.environ

class ExecutionError(Exception):
    def __init__(self, message, cmd, out, err):
        super(ExecutionError, self).__init__(message)
        self.cmd = cmd
        self.out = out
        self.err = err

    def __str__(self):
        return self.message + "Unable to execute: " + self.cmd + "\n" +\
                                 "stdout: " + self.out + "\nstderr: " + self.err

def exec_command(cmd, inp = None, env = None):
    """ run 'cmd' and return the output;
        cmd should be a tuple or an array
        optionally the input iterable is written into STDIN
        Raises in case of error
    """
    if debug_mode():
        print cmd
    proc = subprocess.Popen(cmd, stdin=subprocess.PIPE, stdout=subprocess.PIPE,
                            stderr=subprocess.PIPE, env=env)
    if inp:
        try:
            for i in inp:
                proc.stdin.write(i)
        except IOError:
            # This probably means arcyon has failed and we'll get a different
            # and more useful error from that, so ignore this.
            pass
    (proc_out, proc_err) = proc.communicate()
    if debug_mode():
        print proc_out, proc_err
    if proc.returncode != 0:
        raise ExecutionError(proc_err, " ".join(cmd), proc_out, proc_err)
    return proc_out


