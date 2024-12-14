# SCIP-Julia-CN

Structure And Interpretation of Computer Programs (= SICP) 的Julia中文版，涵盖通用计算思想体系与Julia特性的介绍。

内容采用 [Pluto.jl](https://github.com/fonsp/Pluto.jl)编制。

[原版](https://uol.de/en/lcs/projects/sicp-with-julia/plutojl)来自德国奥尔登堡大学(Carl von Ossietzky Universität Oldenburg)

## 目录结构

```
README.md 
Notebooks/ # 存放Pluto.jl的notebooks 
start.jl   # 启动Pluto.jl
```

## Quick start

1. 用VSCode打开项目
2. 配置环境
```julia
using Pkg
Pkg.activate(".")
Pkg.instantiate()
```
3. 运行start.jl文件
4. 在Pluto.jl中打开notebooks
