#!/usr/bin/env python3
import os
import json
import requests
from getpass import getpass

github_username = input('Github username: ')
github_password = getpass('Github password: ')

auth_tuple = (github_username, github_password)

gistmap = {
    '~/.zshrc': ('0904a88778a7dfdb2bc9816f03db30f3', '.zshrc_home'), # path: (id, gist filename)
    '~/.vimrc': ('79328746f59926d820e288fa68f41ac6', '.vimrc_home'),
    '~/.spacemacs': ('7a0098cfd3ae408569cd200acaa7d766', ),
}

def upload(id_, gist_fn, fcontent):
    patch_data = {
        "files": {
            gist_fn: {
                "content": fcontent
            }
        }
    }
    res = requests.patch('https://api.github.com/gists/' + id_, auth=auth_tuple, data=json.dumps(patch_data))


for fname, t in gistmap.items():
    if len(t) == 1:
        id = t[0]
        gist_fn = os.path.basename(fname)
    else:
        id, gist_fn = t
    with open(os.path.expanduser(fname), 'r') as f:
        fcontent = f.read()
        res = requests.get('https://api.github.com/gists/' + id, auth=auth_tuple)
        content = json.loads(res.text)['files'][gist_fn]['content']
        if(content!=fcontent):
            upload(id, gist_fn, fcontent)
            print('Updated {0}'.format(fname))

