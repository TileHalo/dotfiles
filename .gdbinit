set environment CK_FORK=no
define frame
    info frame
    info args
    info locals
end
document frame
Syntax: frame
| Print stack frame.
end

set debuginfod enabled on
