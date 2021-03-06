import os
import sys
import util

def resolve(path_to_library):
    with open(path_to_library) as f:
        source = "\n" + f.read()
    source += "\n" + util.generate_required_content(path_to_library)
    return source

def main():
    if len(sys.argv) != 2:
        print("Usage: " + os.path.basename(__file__) + " path/to/library")
        exit(1)
    path = os.path.abspath(__file__)
    os.chdir(os.path.dirname(path))
    path_to_library = os.path.abspath(sys.argv[1])
    print (resolve(path_to_library))

if __name__ == "__main__":
    main()