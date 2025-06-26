- For mac need to add the following to avoid validation warning ( https://vulkan-tutorial.com/Drawing_a_triangle/Setup/Logical_device_and_queues)
    ```cpp
   // in instance extension
  
  extensions.emplace_back(VK_KHR_PORTABILITY_ENUMERATION_EXTENSION_NAME);
  extensions.emplace_back("VK_KHR_get_physical_device_properties2");
   ...
  // in instance create info
  createInfo.flags |= VK_INSTANCE_CREATE_ENUMERATE_PORTABILITY_BIT_KHR;
  
   // in device create info
    VkDeviceCreateInfo createInfo{};
    
    const char* deviceExtensions[] = {
                "VK_KHR_portability_subset"  // ← ADD THIS
            };
    createInfo.enabledExtensionCount = 1;
    createInfo.ppEnabledExtensionNames = deviceExtensions;
    ```