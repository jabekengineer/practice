import sys
def show_implementation() -> str:
    return sys.implementation.name

def show_version() -> str:
    v = sys.implementation.version
    return f"{v.major}.{v.minor}.{v.micro}"


def main():
    print(f"implementation: {show_implementation()}")
    print(f"version: {show_version()}")

if __name__ == "__main__":
    main()
