#ifndef RENDERER
#define RENDERER
#include <GLFW/glfw3.h>
#include <stdint.h>
#include <vulkan/vulkan.h>
#include <stdbool.h>

typedef struct AppInfo
{
    char* app_name;
    GLFWwindow* window;
    uint16_t window_width;
    uint16_t window_height;
    VkInstance instance;
}AppInfo;


void run();

//extern int validation_layer_count;
//extern char* validation_layers[] = {
  //  "VK_LAYER_KHRONOS_validation"
//};

//#ifdef NDEBUG
  //  extern const bool enable_validation_layers = false;
//#else
  //  extern const bool enable_validation_layers = true;
//#endif

extern bool check_validation_layer_support();


void init_window(AppInfo* info);

void init_vulkan(AppInfo* info);

void main_loop(AppInfo* info);

void cleanup(AppInfo* info);

void create_instance(AppInfo* info);

#endif