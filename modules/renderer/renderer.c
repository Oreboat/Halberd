#include "renderer/renderer.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void run(){
    AppInfo info;
    //these are temporary values, eventually there will be a config file to define all this
    info.window_width = 1280; 
    info.window_height = 720;
    info.app_name = "Halberd";
    //create window
    init_window(&info);
    //create vulkan instance
    init_vulkan(&info);
    //run the main loop of the engine
    main_loop(&info);
    //cleanup the engine
    cleanup(&info);
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

    
    
}

void init_vulkan(AppInfo* info){
    create_instance(info);
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

void cleanup(AppInfo* info){
    vkDestroyInstance(info->instance, NULL);
    glfwDestroyWindow(info->window);
    glfwTerminate();
}

void create_instance(AppInfo* info){
    VkApplicationInfo vk_app;
    memset(&vk_app, 0, sizeof(vk_app));
    vk_app.sType = VK_STRUCTURE_TYPE_APPLICATION_INFO;
    vk_app.pApplicationName = info->app_name;
    vk_app.applicationVersion = VK_MAKE_VERSION(0,0,1);
    vk_app.pEngineName = "Halberd";
    vk_app.engineVersion = VK_MAKE_VERSION(0,0,1);
    vk_app.apiVersion = VK_API_VERSION_1_3;

    VkInstanceCreateInfo create_info;
    memset(&create_info, 0, sizeof(create_info));
    create_info.sType = VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO;
    create_info.pApplicationInfo = &vk_app;

    
    uint32_t glfw_extension_count = 0;
    const char** glfw_extensions;

    glfw_extensions = glfwGetRequiredInstanceExtensions(&glfw_extension_count);

    create_info.enabledExtensionCount = glfw_extension_count;
    create_info.ppEnabledExtensionNames = glfw_extensions;

    create_info.enabledLayerCount = 0;




    if(vkCreateInstance(&create_info, NULL, &info->instance) != VK_SUCCESS){
        printf("Failed to create Vulkan Instance");
        return;
    }


    uint32_t extension_count = 0;
    void* extensions = (VkExtensionProperties*)malloc(extension_count * sizeof(VkExtensionProperties));
    vkEnumerateInstanceExtensionProperties(NULL, &extension_count, extensions);

    free(extensions);
}

bool check_validation_layer_support(){
    return false;
}
