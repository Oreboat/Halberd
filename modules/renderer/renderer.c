#include "renderer/renderer.h"
#include <stdio.h>


void run(){
    AppInfo info;
    //these are temporary values, eventually there will be a config file to define all this
    info.window_width = 1280; 
    info.window_height = 720;
    info.app_name = "Halberd";
    //create window
    init_window(&info);
    //create vulkan instance
    init_vulkan();
    //run the main loop of the engine
    main_loop(&info);
    //cleanup the engine
    cleanup();
}

void init_window(AppInfo* info){
    if(!glfwInit()){
        printf("Failed to create GLFW instance!\n");
        return;
    }
    glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API);

    info->window = glfwCreateWindow(info->window_width, info->window_height, info->app_name, NULL, NULL);

    if(!info->window){
        printf("Failed to create GLFW window!\n");
        glfwTerminate();
        return;
    }

    glfwMakeContextCurrent(info->window);

}

void init_vulkan(){

}

void main_loop(AppInfo* info){
    if(!info->window){
        return;
    }
    
    while (!glfwWindowShouldClose(info->window))
    {
        glfwPollEvents();
    }
    
}

void cleanup(){

}

