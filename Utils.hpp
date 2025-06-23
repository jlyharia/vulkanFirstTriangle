//
// Created by Yihung Lee on 6/22/25.
//

#pragma once
#define GLFW_INCLUDE_VULKAN

void checkAvailablePhysicalDeviceExtension(VkPhysicalDevice &physicalDevice) {
    uint32_t phExtensionCount = 0;
    vkEnumerateDeviceExtensionProperties(physicalDevice, nullptr, &phExtensionCount, nullptr);
    std::vector<VkExtensionProperties> phyExtensions(phExtensionCount);
    vkEnumerateDeviceExtensionProperties(physicalDevice, nullptr, &phExtensionCount, phyExtensions.data());
    std::cout << "available physical extensions:\n";
    for (const auto &extension: phyExtensions) {
        std::cout << '\t' << extension.extensionName << '\n';
    }
}

void checkAvailableInstanceExtensions() {
    uint32_t extensionCount = 0;
    vkEnumerateInstanceExtensionProperties(nullptr, &extensionCount, nullptr);
    std::vector<VkExtensionProperties> extensions(extensionCount);
    vkEnumerateInstanceExtensionProperties(nullptr, &extensionCount, extensions.data());
    std::cout << "available extensions:\n";
    for (const auto &extension: extensions) {
        std::cout << '\t' << extension.extensionName << '\n';
    }
}
