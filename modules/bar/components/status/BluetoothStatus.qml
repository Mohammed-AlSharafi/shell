import QtQuick
import Quickshell.Bluetooth
import qs.components

MaterialIcon {
    id: root

    required property color colour

    animate: true
    text: {
        if (!Bluetooth.defaultAdapter?.enabled)
            return "bluetooth_disabled";
        if (Bluetooth.devices.values.some(d => d.connected))
            return "bluetooth_connected";
        return "bluetooth";
    }
    color: root.colour
}
