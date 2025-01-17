# julia +nightly juliac.jl --output-exe game --trim game.jl --experimental
# julia +nightly --project=/home/kyjor/Documents/Projects/Julia/juliac juliac.jl --output-exe game --trim=unsafe-warn game.jl --experimental
module Game
include("lib/LibSDL2.jl")
using .LibSDL2
Base.@ccallable function main()::Cint
    LibSDL2.libsdl2 = joinpath(pwd(), "lib", "libSDL2.so")  
    LibSDL2.libsdl2_image = joinpath(pwd(), "lib", "image", "libSDL2_image-2.0.so")  
    cur_dir::String = pwd()
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

    w_ref, h_ref = Ref{Cint}(0), Ref{Cint}(0)
    SDL_QueryTexture(tex, C_NULL, C_NULL, w_ref, h_ref)

    try
        w, h = w_ref[], h_ref[]
        x = (1000 - w) ÷ 2
        y = (1000 - h) ÷ 2
        dest_ref = Ref(SDL_Rect(x, y, w, h))
        close = false
        speed = 300
        while !close
            event_ref = Ref{SDL_Event}()
            while Bool(SDL_PollEvent(event_ref))
                evt = event_ref[]
                evt_ty = evt.type
                if evt_ty == SDL_QUIT
                    close = true
                    break
                elseif evt_ty == SDL_KEYDOWN
                    scan_code = evt.key.keysym.scancode
                    if scan_code == SDL_SCANCODE_W || scan_code == SDL_SCANCODE_UP
                        y -= speed / 30
                        break
                    elseif scan_code == SDL_SCANCODE_A || scan_code == SDL_SCANCODE_LEFT
                        x -= speed / 30
                        break
                    elseif scan_code == SDL_SCANCODE_S || scan_code == SDL_SCANCODE_DOWN
                        y += speed / 30
                        break
                    elseif scan_code == SDL_SCANCODE_D || scan_code == SDL_SCANCODE_RIGHT
                        x += speed / 30
                        break
                    else
                        break
                    end
                end
            end
    
            x + w > 1000 && (x = 1000 - w;)
            x < 0 && (x = 0;)
            y + h > 1000 && (y = 1000 - h;)
            y < 0 && (y = 0;)
    
            dest_ref[] = SDL_Rect(x, y, w, h)
            SDL_RenderClear(renderer)
            SDL_RenderCopy(renderer, tex, C_NULL, dest_ref)
            dest = dest_ref[]
            x, y, w, h = dest.x, dest.y, dest.w, dest.h
            SDL_RenderPresent(renderer)
    
            SDL_Delay(1000 ÷ 60)
        end
    finally
        SDL_DestroyTexture(tex)
        SDL_DestroyRenderer(renderer)
        SDL_DestroyWindow(win)
        SDL_Quit()
    end
    return 0
end
end # End of module HelloWorld 