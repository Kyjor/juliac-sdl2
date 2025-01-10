# julia +nightly juliac.jl --output-exe game --trim game.jl --experimental
# julia +nightly --project=/home/kyjor/Documents/Projects/Julia/juliac juliac.jl --output-exe game --trim=unsafe-warn game.jl --experimental
module Game
libsdl2::String = joinpath(pwd(), "lib", "libSDL2.so")  
#libcalls::String = joinpath(pwd(), "lib", "libSDLCalls.so")  
include("lib/LibSDL2.jl")
const cur_dir::String = pwd()
using .LibSDL2
Base.@ccallable function main()::Cint
    SDL_GL_SetAttribute(SDL_GL_MULTISAMPLEBUFFERS, 16)
    SDL_GL_SetAttribute(SDL_GL_MULTISAMPLESAMPLES, 16)
    SDL_Init(SDL_INIT_EVERYTHING)
    win = SDL_CreateWindow("Game", SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, 1000, 1000, SDL_WINDOW_SHOWN)
    SDL_SetWindowResizable(win, SDL_TRUE)

    renderer = SDL_CreateRenderer(win, -1, SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC)
    keep_going = true
    count = 0
    
    surface = IMG_Load(joinpath(cur_dir, "assets", "cat.png"))
    tex = SDL_CreateTextureFromSurface(renderer, surface)
    SDL_FreeSurface(surface)
    while keep_going
        count += 1
        if count == 1000000
            keep_going = false
        end
        event_ref = Ref{SDL_Event}()
        while Bool(SDL_PollEvent(event_ref))
            evt = event_ref[]
            println(Core.stdout, "event type = $(evt.type)")
            if evt.type == SDL_QUIT
                keep_going = false
            end
        end

        SDL_Delay(10)
    end
    SDL_Quit()
    println(Core.stdout, "$(count)")
    return 0
end
end # End of module HelloWorld 