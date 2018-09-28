#!/usr/bin/env python3
"""
Util file containing common functions

File: montage_util.py

Copyright 2018 Ankur Sinha
Author: Ankur Sinha <sanjay DOT ankur AT gmail DOT com>
"""

import subprocess
from subprocess import CalledProcessError


def make_montage(args, output_file):
    """Make the montage"""
    try:
        print("Running montage with args: {}".format(args))
        status = subprocess.run(args=['montage'] + args,
                                stdout=subprocess.PIPE,
                                stderr=subprocess.PIPE)
        status.check_returncode()
    except CalledProcessError as cpe:
        print(
            "{} errored with return code {}".format(
                cpe.cmd, cpe.returncode))
        print("\n" + cpe.stderr.decode())
    else:
        print("{} montage created".format(output_file))
