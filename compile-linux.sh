#!/bin/bash
echo "Hello from script" > output.txt
mkdir shaders
glslc shaders/09_shader_base.vert -o shaders/vert.spv
glslc shaders/09_shader_base.frag -o shaders/frag.spv