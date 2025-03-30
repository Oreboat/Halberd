#ifndef RENDERER
#define RENDERER
#include <GLFW/glfw3.h>
#include <stdint.h>

typedef struct AppInfo
{
    char* app_name;
    GLFWwindow* window;
    uint16_t window_width;
    uint16_t window_height;
}AppInfo;


void run();

void init_window(AppInfo* info);

void init_vulkan();

void main_loop(AppInfo* info);

void cleanup();



#endif