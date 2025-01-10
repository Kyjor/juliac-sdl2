# julia +nightly juliac.jl --output-exe hello --trim helloworld.jl --experimental
# julia +nightly --project=/home/kyjor/Documents/Projects/Julia/juliac juliac.jl --output-exe hello --trim=unsafe-warn helloworld.jl --experimental
module HelloWorld
libsdl2::String = joinpath(pwd(), "lib", "libSDL2.so")  
include("lib/LibSDL2.jl")
using .LibSDL2
Base.@ccallable function main()::Cint
    #println(Core.stdout, "Hello, Toto")
    LibSDL2.test()
   #LibSDL2.test()
    # string::String = "str"
    # println(Core.stdout, "Hello, $(C_NULL)")
    # GC.@preserve str begin
    #     println(Core.stdout, "Hello, $(C_NULL)")
    # end
   # LibSDL2.test()
    # SDL_CreateWindow( 
    #     "windowTitle", 
    #     SDL_WINDOWPOS_CENTERED, 
    #     SDL_WINDOWPOS_CENTERED, 
    #     1280, 
    #     720,
    #     4 | 32
    # )
    
    return 0
end
# mutable struct SDL_Window end
# const SDL_WINDOWPOS_CENTERED_MASK = Cuint(0x2fff0000)
# SDL_WINDOWPOS_CENTERED_DISPLAY(X) = SDL_WINDOWPOS_CENTERED_MASK | X

# function SDL_PumpEvents()
#     ccall((:SDL_PumpEvents, libsdl2), Cvoid, ())
# end

# const SDL_WINDOWPOS_CENTERED = SDL_WINDOWPOS_CENTERED_DISPLAY(0)
# const Uint32 = UInt32
# function SDL_CreateWindow(title, x, y, w, h, flags)
#     ccall((:SDL_CreateWindow, libsdl2), Ptr{SDL_Window}, (Ptr{Cchar}, Cint, Cint, Cint, Cint, Uint32), title, x, y, w, h, flags)
# end

# function SDL_Init(flags)
#     ccall((:SDL_Init, libsdl2), Cint, (Uint32,), flags)
# end

# function SDL_GetPlatform()
#     ccall((:SDL_GetPlatform, libsdl2), Ptr{Cchar}, ())
# end

# const SDL_INIT_TIMER = Cuint(0x00000001)

# const SDL_INIT_AUDIO = Cuint(0x00000010)

# const SDL_INIT_VIDEO = Cuint(0x00000020)

# const SDL_INIT_JOYSTICK = Cuint(0x00000200)

# const SDL_INIT_HAPTIC = Cuint(0x00001000)

# const SDL_INIT_GAMECONTROLLER = Cuint(0x00002000)

# const SDL_INIT_EVENTS = Cuint(0x00004000)

# const SDL_INIT_SENSOR = Cuint(0x00008000)

# const SDL_INIT_NOPARACHUTE = Cuint(0x00100000)

# const SDL_INIT_EVERYTHING = ((((((SDL_INIT_TIMER | SDL_INIT_AUDIO) | SDL_INIT_VIDEO) | SDL_INIT_EVENTS) | SDL_INIT_JOYSTICK) | SDL_INIT_HAPTIC) | SDL_INIT_GAMECONTROLLER) | SDL_INIT_SENSOR
end # End of module HelloWorld 