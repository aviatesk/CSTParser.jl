function parse_kw(ps::ParseState, ::Type{Val{Tokens.CONST}})
    start = ps.t.startbyte
    kw = INSTANCE(ps)
    arg = parse_expression(ps)
    return EXPR(kw, SyntaxNode[arg], ps.nt.startbyte - start)
end

function parse_kw(ps::ParseState, ::Type{Val{Tokens.GLOBAL}})
    start = ps.t.startbyte
    kw = INSTANCE(ps)
    arg = parse_expression(ps)
    return EXPR(kw, SyntaxNode[arg], ps.nt.startbyte - start)
end

function parse_kw(ps::ParseState, ::Type{Val{Tokens.LOCAL}})
    start = ps.t.startbyte
    kw = INSTANCE(ps)
    arg = parse_expression(ps)
    return EXPR(kw, SyntaxNode[arg], ps.nt.startbyte - start)
end

function parse_kw(ps::ParseState, ::Type{Val{Tokens.RETURN}})
    start = ps.t.startbyte
    kw = INSTANCE(ps)
    args = SyntaxNode[closer(ps) ? NOTHING : parse_expression(ps)]
    return  EXPR(kw, args, ps.nt.startbyte - start)
end

function parse_kw(ps::ParseState, ::Type{Val{Tokens.END}})
    # if ps.closer.square
        return IDENTIFIER(ps.nt.startbyte - ps.t.startbyte, ps.t.startbyte, :end)
    # else
    #     error("unexpected `end`")
    # end
end

function next(x::EXPR, s::Iterator{:const})
    if s.i == 1
        return x.head, +s
    elseif s.i == 2
        return x.args[1], +s
    end
end

function next(x::EXPR, s::Iterator{:global})
    if s.i == 1
        return x.head, +s
    elseif s.i == 2
        return x.args[1], +s
    end
end

function next(x::EXPR, s::Iterator{:local})
    if s.i == 1
        return x.head, +s
    elseif s.i == 2
        return x.args[1], +s
    end
end

function next(x::EXPR, s::Iterator{:return})
    if s.i == 1
        return x.head, +s
    elseif s.i == 2
        return x.args[1], +s
    end
end