# python >= 3.5

import os
import glob
import subprocess

source_dir = 'sources-latin1'
target_dir = 'sources-utf8'
base_dir = os.getcwd()

if os.path.isdir(target_dir):
    raise ValueError('Directory {} aready exists.'.format(target_dir))

os.chdir(os.path.join(base_dir, source_dir))
for filename in glob.glob('**', recursive=True):
    if os.path.isfile(filename):
        source_path = os.path.join(base_dir, source_dir, filename)
        target_path = os.path.join(base_dir, target_dir, filename)

        directory_to_create = os.path.dirname(target_path)
        os.makedirs(directory_to_create, mode=0o775, exist_ok=True)

        command = 'iconv -f iso-8859-1 -t utf-8 {} > {}'.format(source_path, target_path)
        subprocess.run(command, shell=True, check=True)
