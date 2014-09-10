#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
certifi.py
~~~~~~~~~~

This module returns the installation location of cacert.pem.
"""

import os

def where():
    print("called where in certifi")
    f = os.path.split(__file__)[0]
    print(f)

    return os.path.join(f, 'cacert.pem')

if __name__ == '__main__':
    print(where())
