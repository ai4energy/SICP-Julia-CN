struct interv
    car::Int
    cdr::Int
end

cons(x, y) = interv(x, y)

function make_interval(a, b)
    cons(a, b)
end # function make_interval

car(cons::interv) = cons.car

cdr(cons::interv) = cons.cdr

lower_bound(cons::interv) = car(cons)

upper_bound(cons::interv) = cdr(cons)

function add_interval(x, y)
    make_interval(
        +(lower_bound(x), lower_bound(y)),
        +(upper_bound(x), upper_bound(y)))
end # function add_interval

Base.show(io::IO, x::interv) = print(io, "[$(lower_bound(x)), $(upper_bound(x))]")

Base.:(+)(x::interv, y::interv) = add_interval(x, y)

(~)(x::Int, y::Int) = make_interval(x, y)

println("构造：",make_interval(1, 2))
println("构造：",1~2)
println("加法：",make_interval(1, 2) + make_interval(3, 4))
println("加法：",(1~2) + (3~4))
# 定义一个新符号，构造一个区间
