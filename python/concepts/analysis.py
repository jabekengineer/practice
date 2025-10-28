
# python lexical analysis and syntax is a mixture of extended backus naur form (algol, and
# parsing expression grammar


# EBNF uses symbols to create rules
# [] - optional element
# {} repetitions of an element
# () - element grouping
# | or choice between alternatives
# = is defined as

# name refers to another rule

# lexical analyzer produces stream of tokens
# program is logical lines ending with NEWLINE
# physical lines are sequences of characters terminated by
# built-in file objects have a readline method whose interface works with open()
from typing import TypeAlias, Literal

# from _typeshed import OpenTextModeReading
OpenTextModeReading: TypeAlias = Literal['r']
read_text: OpenTextModeReading = 'r'

from pathlib import Path
file = Path("/workspace/data/notation.txt")

from builtins import open
from io import TextIOWrapper
file_t: TextIOWrapper = open(file=file, mode=read_text)
try:
    line1_t: str = file_t.read()
    print(f"Tokenizing source: {line1_t}")
finally:
    file_t.close()

# from _typeshed import OpenBinaryModeReading
from io import BufferedReader
OpenBinaryModeReading: TypeAlias = Literal['rb']
read_binary: OpenBinaryModeReading = 'rb'
file_b: BufferedReader = open(file=file, mode=read_binary)
from collections.abc import Generator
from tokenize import TokenInfo, tokenize
# A generator is an iterable
tokenized: Generator[TokenInfo] = tokenize(file_b.readline)
print("\n".join([f"{token}" for token in tokenized]))

import ast
# ast parse takes a readable buffer from stdin or bytes from a file
from ast import Module, Assign
file_b.seek(0)
node: Module = ast.parse(source=file_b.read())

import astpretty
print(f"\nAST: {astpretty.pformat(node)}")

def print_ast_tree(node, indent=0):
    """Print AST as a tree structure"""
    spaces = "  " * indent
    node_name = node.__class__.__name__
    print(f"{spaces}{node_name}")

    for field, value in ast.iter_fields(node):
        print(f"{spaces}  {field}:")
        if isinstance(value, list):
            for item in value:
                if isinstance(item, ast.AST):
                    print_ast_tree(item, indent + 2)
                else:
                    print(f"{spaces}    {repr(item)}")
        elif isinstance(value, ast.AST):
            print_ast_tree(value, indent + 2)
        else:
            print(f"{spaces}    {repr(value)}")
print_ast_tree(node)


file_b.close()



# line1_b = BytesIO(b'a = 1\n')
# line1_t: Generator[TokenInfo] = tokenize.tokenize(readline=line1_b.readline)
# a =

# # simulating _io._IOBase.readline(self, size:int) -> bytes
# line1Dupe= lambda: bytes('a=1', encoding='utf-8')
# # built-in file objects have a readline() method

# line1_t = tokenize.tokenize(readline=line1Dupe)

# # construct tokenized input yourself


# # line1=f"line1{token.EQUAL}'a'{token.NEWLINE}"
# _ast = ast.parse(line1)
# print(ast.dump(node=_ast, include_attributes=True))
