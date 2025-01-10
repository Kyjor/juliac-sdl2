#include "library.h"

#include <stdint.h>
#include <stdio.h>
#include "SDL2-2.30.11/include/SDL.h"

void hello(void) {
    printf("Hello, World!\n");
    printf("Hello, World!\n");
}

SDL_Renderer* create_window_and_renderer(void) {
    uint32_t width = 600;
    uint32_t height = 600;

    // if (SDL_Init(SDL_INIT_EVERYTHING) != 0) {
    //     return 1;
    // }

    printf("Creating window and renderer...\n");
    SDL_Window *window = SDL_CreateWindow(
         "MyGame",
         SDL_WINDOWPOS_CENTERED,
         SDL_WINDOWPOS_CENTERED,
         width,
         height,
         SDL_WINDOW_OPENGL
     );

    if (!window) {
        //ERROR_EXIT("Failed to init window: %s\n", SDL_GetError());
        exit(1);
    }

    SDL_Renderer *renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED);

    return renderer;
}
//-- If installed with: sudo dnf install SDL2-devel
// cc -fPIC -shared -o /home/kyjor/Documents/Projects/Julia/juliac-sdl2/lib/libSDLCalls.so library.c -L/usr/lib64 -lSDL2

//Otherwise, run in this directory, replacing with your path to the lib folder
//  cc -fPIC -shared -o /home/kyjor/Documents/Projects/Julia/juliac-sdl2/lib/libSDLCalls.so library.c -L/home/kyjor/Documents/Projects/Julia/juliac-sdl2/lib -lSDL2
