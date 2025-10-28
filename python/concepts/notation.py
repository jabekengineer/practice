"""
name      ::= lc_letter (lc_letter | "_")*
lc_letter ::= "a"..."z"
"""

def is_lambda_calculus_letter(c: str) -> bool:
    b: bytes = c.encode('utf-8')
    h: str = b.hex()
    return (h >= '61' and h <= '7A')

def is_valid_py_bnf_name(str: str) -> bool:
    """"""

    if not is_lambda_calculus_letter(str[0]):
        return False

    return str.isalpha() and all([is_lambda_calculus_letter(c.lower()) for c in str])
