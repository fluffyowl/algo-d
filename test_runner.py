#!/usr/bin/python3

import os
import subprocess
import tempfile

OJ_DOWNLOAD_COMMAND = ["oj", "download"]
OJ_EXECUTE_COMMAND = ["oj", "test", "--tle", "10"]
COMPILER_COMMAND = ["dmd", "-m64", "-w", "-O", "-release", "-inline", "-J./"]

class TestRunner:
    def __init__(self, test_path):
        self.test_path = test_path
        self.problem_url = self.get_problem_url(test_path)
        self.required_library_paths = self.get_required_library_paths(test_path)

    def run(self):
        with tempfile.TemporaryDirectory(prefix='tmp-') as working_dir:
            source_path = os.path.join(working_dir, "tmp.d")
            binary_path = os.path.join(working_dir, "tmp.out")
            test_cases_path = os.path.join(working_dir, "testcases/")
            self.generate_source_file(source_path)
            self.compile_source_file(source_path, binary_path)
            self.download_test_cases(test_cases_path)
            self.run_tests(binary_path, test_cases_path)

    def get_problem_url(self, test_path):
        with open(test_path, 'r') as test_file:
            for line in test_file:
                if line.startswith("//") and "problem:" in line:
                    return line.rstrip().split()[-1]

    def get_required_library_paths(self, test_path):
        required_library_paths = []
        with open(test_path, 'r') as test_file:
            for line in test_file:
                if line.startswith("//") and "require:" in line:
                    required_library_paths.append(line.rstrip().split()[-1])
        return required_library_paths

    def generate_source_file(self, source_path):
        with open(source_path, 'w') as source_file:
            with open(self.test_path) as test_file:
                for line in test_file:
                    source_file.write(line)
            for library_path in self.required_library_paths:
                source_file.write('\n')
                with open(library_path) as library_file:
                    for line in library_file:
                        source_file.write(line)

    def compile_source_file(self, source_path, binary_path):
        compile_command = COMPILER_COMMAND + ["-of"+binary_path, source_path]
        subprocess.call(compile_command)

    def download_test_cases(self, test_cases_path):
        download_command = OJ_DOWNLOAD_COMMAND + ["--system", self.problem_url, "-d", test_cases_path]
        subprocess.call(download_command)

    def run_tests(self, binary_path, test_cases_path):
        execute_command = OJ_EXECUTE_COMMAND + ["--c", binary_path, "-d", test_cases_path]
        subprocess.call(execute_command)


def run_specific_test(test_path):
    test_runner = TestRunner(test_path)
    test_runner.run()

def run_all_tests():
    for test_path in os.listdir('test/'):
        if not test_path.endswith('.d'):
            continue
        run_specific_test(os.path.join('test', test_path))

def main():
    run_all_tests()

if __name__ == '__main__':
    main()
