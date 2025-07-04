#!/bin/bash
echo "Hello from script" > output.txt

/usr/local/bin/glslc /Users/johnny/Code/Vulkan/firstTriangle/shaders/09_shader_base.vert -o vert.spv
/usr/local/bin/glslc /Users/johnny/Code/Vulkan/firstTriangle/shaders/09_shader_base.frag -o frag.spv