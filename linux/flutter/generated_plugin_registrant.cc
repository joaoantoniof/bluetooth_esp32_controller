//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <simple_flutter_ble/flutter_ble_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) simple_flutter_ble_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "FlutterBlePlugin");
  flutter_ble_plugin_register_with_registrar(simple_flutter_ble_registrar);
}
