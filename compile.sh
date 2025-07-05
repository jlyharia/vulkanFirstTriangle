#!/bin/bash
echo "Hello from script" > output.txt
mkdir shaders
/usr/local/bin/glslc /Users/johnny/Code/Vulkan/firstTriangle/shaders/09_shader_base.vert -o shaders/vert.spv
/usr/local/bin/glslc /Users/johnny/Code/Vulkan/firstTriangle/shaders/09_shader_base.frag -o shaders/frag.spv