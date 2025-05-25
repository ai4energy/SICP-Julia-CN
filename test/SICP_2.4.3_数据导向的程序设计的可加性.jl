const OP_TABLE = Dict{Tuple{String, String}, Any}()  # (操作名, 类型标签) → 实现函数

# 注册函数：将类型与操作绑定
function register(op::String, type::String, func::Function)
    OP_TABLE[(op, type)] = func
end

# 通用调度函数：根据类型标签查找实现
function apply_generic(op::String, args...)
    types = [typeof(arg).name.name for arg in args]  # 获取参数类型标签
    func = OP_TABLE[(op, join(types, "+"))]  # 约定用"+"连接多类型标签（如"Rectangular+Polar"）
    if func === nothing
        error("未实现操作 $op 对类型 $(types) 的支持")
    end
    return func(args...)
end

# 2.1 直角坐标包
function install_rectangular_package()
    # 注册基础操作（如获取实部、虚部）
    register("real_part", "Rectangular", z -> z.x)
    register("imag_part", "Rectangular", z -> z.y)
    # 注册构造函数
    register("make", "Rectangular", (x, y) -> Rectangular(x, y))
end
install_rectangular_package()

# 2.2 极坐标包
function install_polar_package()
    register("real_part", "Polar", z -> z.r*cos(z.θ))
    register("imag_part", "Polar", z -> z.r*sin(z.θ))
    register("magnitude", "Polar", z -> z.r)
    register("angle", "Polar", z -> z.θ)
    register("make", "Polar", (r, θ) -> Polar(r, θ))
end
install_polar_package()

# 通用加法：不关心具体类型，仅通过调度获取实部和虚部
function add(z1, z2)
    x = apply_generic("real_part", z1) + apply_generic("real_part", z2)
    y = apply_generic("imag_part", z1) + apply_generic("imag_part", z2)
    # 用直角坐标表示结果（也可扩展为返回任意类型）
    apply_generic("make", "Rectangular", x, y)
end

# 通用乘法：利用极坐标的乘法性质（模相乘，角度相加）
function mul(z1, z2)
    # 尝试获取极坐标的模和角度（若类型支持）
    r1 = get_optional("magnitude", z1, z -> z.x)  # 若未注册magnitude，则用实部作为默认
    θ1 = get_optional("angle", z1, z -> atan(z.y, z.x))
    r2 = get_optional("magnitude", z2, z -> z.x)
    θ2 = get_optional("angle", z2, z -> atan(z.y, z.x))
    # 用极坐标表示结果
    apply_generic("make", "Polar", r1*r2, θ1 + θ2)
end

# 辅助函数：安全获取操作，若无则返回默认值
function get_optional(op, z, default_func)
    try
        return apply_generic(op, z)
    catch
        return default_func(z)
    end
end

struct Triple; a::Float64; b::Float64; c::Float64; end  # 假设三元数用(a, b, c)表示
function install_triple_package()
    # 注册三元数的实部（假设实部为a，虚部为b，c为额外维度）
    register("real_part", "Triple", z -> z.a)
    register("imag_part", "Triple", z -> z.b)
    # 注册构造函数
    register("make", "Triple", (a, b, c) -> Triple(a, b, c))
end
install_triple_package()

# 测试：三元数与直角坐标相加（自动调度）
z1 = apply_generic("make", "Rectangular", 3, 4)  # 3+4i
z2 = apply_generic("make", "Triple", 1, 2, 3)    # (1,2,3)
z3 = add(z1, z2)  # 自动通过 real_part 和 imag_part 调度，结果为 Rectangular(4, 6)
println("z3 = ", z3.x, " + ", z3.y, "i")  # 输出：4 + 6i