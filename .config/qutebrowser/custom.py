#!/usr/bin/env python3
def enable_js(glob):
    config.set('content.javascript.enabled', True, glob)

def disable_js(glob):
    config.set('content.javascript.enabled', False, glob)
