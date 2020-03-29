import os
import platform
import subprocess
import sys
import tempfile

import resolve

def copy_to_clipboard(to_be_copied):
    platform_name = platform.system()
    if platform_name == 'Windows':
        copy_command = 'clip.exe'
    elif platform_name == 'Darwin':
        copy_command = 'pbcopy'
    else:
        print('This OS is not supported.')
        exit(1)

    p1 = subprocess.Popen(["echo", to_be_copied], stdout=subprocess.PIPE)
    p2 = subprocess.Popen([copy_command], stdin=p1.stdout, stdout=subprocess.PIPE)
    p1.stdout.close()
    output = p2.communicate()[0]

    if p2.returncode == 0:
        print('Scuccessfully copied to clipboard')
    else:
        print('Failed to copy to clipboard.')

    return p2.returncode

def main():
    if len(sys.argv) != 2:
        print("Usage: " + os.path.basename(__file__) + " path/to/library")
        exit(1)
    path = os.path.abspath(__file__)
    os.chdir(os.path.dirname(path))
    path_to_library = os.path.abspath(sys.argv[1])

    resolved_content = resolve.resolve(path_to_library)
    return_code = copy_to_clipboard(resolved_content)
    exit(return_code)

if __name__ == '__main__':
    main()
