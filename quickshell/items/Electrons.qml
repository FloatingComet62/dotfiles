import QtQuick
import QtQuick.Layouts

RowLayout {
  spacing: 0
  Text {
    text: " Electrons:"
    color: shellRoot.white
    font {
      family: shellRoot.fontFamily
      pixelSize: shellRoot.fontSize
    }
  }
  Text {
    text: (batteryCharging ? ("AC/DC(" + battery + ")") : battery)
    color: (battery <= redBatteryPoint) ? shellRoot.red : ((battery <= orangeBatteryPoint) ? shellRoot.orange : shellRoot.green)
    font {
      family: shellRoot.fontFamily
      pixelSize: shellRoot.fontSize
      bold: true
    }
  }
  MouseArea {
    anchors.fill: parent
    onClicked: shellRoot.batteryModeConfig = !shellRoot.batteryModeConfig
  }
}
