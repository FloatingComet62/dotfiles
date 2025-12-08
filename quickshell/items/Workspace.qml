import QtQuick
import Quickshell.Hyprland

Repeater {
  model: 5

  Text {
    property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)

    text: index + 1
    color: isActive ? shellRoot.green : shellRoot.white
    font {
      pixelSize: shellRoot.fontSize;
      bold: true;
    }

    MouseArea {
      anchors.fill: parent
      onClicked: Hyprland.dispatch("workspace " + (index + 1))
    }
  }
}
