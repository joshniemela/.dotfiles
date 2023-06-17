import Pkg
let
    pkgs = ["Revise", "OhMyREPL"]
    for pkg in pkgs
        if Base.find_package(pkg) === nothing
            Pkg.add(pkg)
        end
    end
end

try
    using Revise
    ENV["JULIA_REVISE"] = "auto"
catch e
    @warn "Error initializing Revise" exception=(e, catch_backtrace())
end

try
    using OhMyREPL
catch e
    @warn "Error initializing OhMyREPL" exception=(e, catch_backtrace())
end

if isfile("Project.toml") && isfile("Manifest.toml")
  Pkg.activate(".")
end
