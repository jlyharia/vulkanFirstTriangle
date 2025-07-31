#!/bin/bash
echo "Hello from script" > output.txt

DIR="shaders"

if [ -d "$DIR" ]; then
    echo "Directory '$DIR' exists."
else
    echo "Directory '$DIR' does not exist. Creating it now..."
    mkdir -p "$DIR"
fi
glslc ../shaders/09_shader_base.vert -o shaders/vert.spv
glslc ../shaders/09_shader_base.frag -o shaders/frag.spv