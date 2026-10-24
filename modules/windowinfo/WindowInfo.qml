import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Caelestia.Config
import qs.components
import qs.services

Item {
    id: root

    required property ShellScreen screen
    required property HyprlandToplevel client

    readonly property real detailsWidth: Tokens.sizes.winfo.detailsWidth
    readonly property real barWidth: Tokens.sizes.bar.innerWidth + Math.max(Tokens.padding.small, Config.border.thickness) * 2
    readonly property real availableWidth: screen.width - barWidth - Config.border.thickness - Tokens.padding.large * 2
    // Keep the panel a consistent size instead of letting the preview grow with the
    // client's aspect ratio (a single maximized window used to make it much wider).
    readonly property real panelWidth: Math.min(detailsWidth * 2, availableWidth)
    readonly property real previewWidth: panelWidth - detailsWidth - Tokens.spacing.medium - Tokens.padding.extraLargeIncreased

    implicitWidth: panelWidth
    implicitHeight: screen.height * Tokens.sizes.winfo.heightMult

    RowLayout {
        id: child

        anchors.fill: parent
        anchors.margins: Tokens.padding.large

        spacing: Tokens.spacing.medium

        Preview {
            screen: root.screen
            client: root.client
            maxWidth: root.previewWidth
        }

        ColumnLayout {
            spacing: Tokens.spacing.medium

            Layout.preferredWidth: root.detailsWidth
            Layout.fillHeight: true

            StyledRect {
                Layout.fillWidth: true
                Layout.fillHeight: true

                color: Colours.tPalette.m3surfaceContainer
                radius: Tokens.rounding.large
                clip: true

                Details {
                    client: root.client
                }
            }

            StyledRect {
                Layout.fillWidth: true
                Layout.preferredHeight: buttons.implicitHeight

                color: Colours.tPalette.m3surfaceContainer
                radius: Tokens.rounding.large

                Buttons {
                    id: buttons

                    client: root.client
                }
            }
        }
    }
}
