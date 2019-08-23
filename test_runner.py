#!/usr/bin/env python3

import os
import subprocess
import sys
import tempfile
import util

TEST_CASES_DIR = "test_cases_cache"
OJ_DOWNLOAD_COMMAND = ["oj", "download"]
OJ_EXECUTE_COMMAND = ["oj", "test", "--tle", "10"]
COMPILER_COMMAND = ["dmd", "-m64", "-w", "-O", "-release", "-inline", "-J./"]

class TestRunner:
    def __init__(self, test_path):
        self.test_path = test_path
        self.problem_url = self.get_problem_url(test_path)
        self.problem_id = self.get_problem_id(self.problem_url)
        self.test_cases_path = os.path.join(TEST_CASES_DIR, self.problem_id)

        if not os.path.exists(TEST_CASES_DIR):
            os.mkdir(TEST_CASES_DIR)

    def run(self):
        with tempfile.TemporaryDirectory(prefix='tmp-') as working_dir:
            source_path = os.path.join(working_dir, "tmp.d")
            binary_path = os.path.join(working_dir, "tmp.out")

            self.generate_source_file(source_path)

            result = self.compile_source_file(source_path, binary_path)
            if not result.passed:
                return result

            result = self.download_test_cases()
            if not result.passed:
                return result

            result = self.run_tests(binary_path)
            return result

    def get_problem_url(self, test_path):
        with open(test_path, 'r') as test_file:
            for line in test_file:
                if line.startswith("//") and "problem:" in line:
                    return line.rstrip().split()[-1]

    def get_problem_id(self, problem_url):
        return problem_url.split("?id=")[-1]

    def generate_source_file(self, source_path):
        with open(source_path, 'w') as source_file:
            with open(self.test_path) as test_file:
                source_file.write(test_file.read())
            source_file.write(util.generate_required_content(self.test_path))

    def compile_source_file(self, source_path, binary_path):
        compile_command = COMPILER_COMMAND + ["-of"+binary_path, source_path]
        code = subprocess.call(compile_command)
        if code == 0:
            return Result(True)
        else:
            return Result(False, 'Failed to compile the source file.')

    def download_test_cases(self):
        if os.path.exists(self.test_cases_path) and len(os.listdir(self.test_cases_path)) != 0:
            print("Test cases already exist. Skip downloading.")
            return Result(True)

        if not os.path.exists(self.test_cases_path):
            os.mkdir(self.test_cases_path)

        download_command = OJ_DOWNLOAD_COMMAND + ["--system", self.problem_url, "-d", self.test_cases_path]
        code = subprocess.call(download_command)
        if code == 0:
            return Result(True)
        else:
            return Result(False, 'Failed to download the test cases.')

    def run_tests(self, binary_path):
        execute_command = OJ_EXECUTE_COMMAND + ["--c", binary_path, "-d", self.test_cases_path]
        code = subprocess.call(execute_command)
        if code == 0:
            return Result(True)
        else:
            return Result(False, "Didn't pass the judge.")


class Result:
    def __init__(self, passed, failure_reason=''):
        self.passed = passed
        self.failure_reason = failure_reason


def print_results(results):
    print("\nOverall results:")
    for test_name, result in sorted(results.items()):
        if result.passed:
            verdict = "\033[92mPASSED\033[0m"
        else:
            verdict = "\033[91mFAILED\033[0m"
            verdict += " (" + result.failure_reason + ")"
        print(test_name, "......", verdict)

    unverified_sources = util.get_unverified_sources()
    if len(unverified_sources) != 0:
        print("\n\033[93mUnverified sources detected.\033[0m")
        for src in unverified_sources:
            print(" - " + src)
        print()

def run(test_path):
    test_runner = TestRunner(test_path)
    return test_runner.run()

def run_tests(test_paths):
    results = {}
    all_passed = True
    for test_path in test_paths:
        if not test_path.endswith('.d'):
            continue
        result = run(test_path)
        results[test_path] = result
        all_passed &= result.passed
    print_results(results)
    return all_passed

def main():
    if len(sys.argv) == 1:
        test_paths = [os.path.join('test', filename) for filename in os.listdir('test')]
    else:
        test_paths = sys.argv[1:]

    all_passed = run_tests(test_paths)
    if not all_passed:
        sys.exit(1)

if __name__ == '__main__':
    main()
