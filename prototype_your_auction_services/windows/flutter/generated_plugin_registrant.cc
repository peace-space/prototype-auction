//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <file_selector_windows/file_selector_windows.h>
#include <flutter_secure_storage_windows/flutter_secure_storage_windows_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
    FileSelectorWindowsRegisterWithRegistrar(
            registry->GetRegistrarForPlugin("FileSelectorWindows"));
    FlutterSecureStorageWindowsPluginRegisterWithRegistrar(
            registry->GetRegistrarForPlugin("FlutterSecureStorageWindowsPlugin"));
}
