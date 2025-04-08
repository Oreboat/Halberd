
# Halberd

Halberd is an open source Entity Component System based game engine built in the C programming Language 

## Why ECS
Entity Component System, or ECS for short, provides a simple, modular approach to game design using the principles of Data Oriented design principles. ECS also provides a way of keeping data stored in the CPU's Cache rather then constantly requesting data from RAM. As such, when done correctly ECS can provide many optimizations over the traditional approach of Object Oriented Design.

## Requirements
a computer that supports Vulkan
cmake if building manually
cargo

## Downloading
to download Halberd you can use

`git clone https://github.com/Oreboat/Halberd.git`

and then simply build it

## Building
Building Halberd yourself is simple, run Cmake . in order to configure the build system, then run Cmake --build ., through the power of commands this will build both the engine and the editor
