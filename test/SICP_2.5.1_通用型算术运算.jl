# 定义抽象类型
abstract type MyNumber end

# 实现整数类型
struct MyInteger <: MyNumber
    value::Int
end

# 实现浮点数类型
struct MyFloat <: MyNumber
    value::Float64
end

# 实现复数类型
struct MyComplex <: MyNumber
    
    real::Float64
    imag::Float64
end

# 加法实现
function Base.:+(a::MyInteger, b::MyInteger)
    MyInteger(a.value + b.value)
end

function Base.:+(a::MyFloat, b::MyFloat)
    MyFloat(a.value + b.value)
end

function Base.:+(a::MyComplex, b::MyComplex)
    MyComplex(a.real + b.real, a.imag + b.imag)
end

# 乘法实现
function Base.:*(a::MyInteger, b::MyInteger)
    MyInteger(a.value * b.value)
end

function Base.:*(a::MyFloat, b::MyFloat)
    MyFloat(a.value * b.value)
end

function Base.:*(a::MyComplex, b::MyComplex)
    real_part = a.real * b.real - a.imag * b.imag
    imag_part = a.real * b.imag + a.imag * b.real
    MyComplex(real_part, imag_part)
end

# 通用的平方计算函数
function square(x::MyNumber)
    x * x
end

# 类型转换
Base.convert(::Type{MyInteger}, x::Int) = MyInteger(x)
Base.convert(::Type{MyFloat}, x::Float64) = MyFloat(x)
Base.convert(::Type{MyComplex}, x::ComplexF64) = MyComplex(real(x), imag(x))

# 显示方法
Base.show(io::IO, x::MyInteger) = print(io, "MyInteger($(x.value))")
Base.show(io::IO, x::MyFloat) = print(io, "MyFloat($(x.value))")
Base.show(io::IO, x::MyComplex) = print(io, "MyComplex($(x.real) + $(x.imag)im)")

# 使用示例
int_result = square(MyInteger(5))
float_result = square(MyFloat(2.5))
complex_result = square(MyComplex(1.0, 2.0))

println("整数平方: ", int_result)
println("浮点数平方: ", float_result)
println("复数平方: ", complex_result)    