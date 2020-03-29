import os
from typing import List, Set


TEST_DIR = "./test"
LIBRARY_DIRS = ["data_structure", "graph", "number"]


def get_required_sources(src_path: str) -> List[str]:
    required_sources = set()

    def dfs(src_path: str) -> None:
        with open(src_path, "r", encoding="utf-8") as src_file:
            for line in src_file:
                if not line.startswith("//") or "require:" not in line:
                    continue
                req = line.rstrip().split()[-1]
                if req in required_sources:
                    continue
                required_sources.add(req)
                dfs(req)

    dfs(src_path)
    return list(required_sources)


def get_unverified_sources() -> List[str]:
    all_sources = []
    unverified_sources = []

    for directory in LIBRARY_DIRS:
        for source in os.listdir(directory):
            if source.endswith(".d"):
                source = os.path.join(directory, source)
                all_sources.append(source)

    for test in os.listdir(TEST_DIR):
        if test.endswith(".d"):
            test = os.path.join(TEST_DIR, test)
            unverified_sources += get_required_sources(test)

    return list(set(all_sources) - set(unverified_sources))


def generate_required_content(src_path: str) -> str:
    required_sources = get_required_sources(src_path)
    content = ""
    for source in required_sources:
        with open(source, "r") as f:
            content += f.read()
        content += "\n"
    return content
