import QtQuick
import QtQuick.Layouts

RowLayout {
  spacing: 0
  Text {
    text: " Radio:"
    color: shellRoot.white
    font {
      family: shellRoot.fontFamily
      pixelSize: shellRoot.fontSize
    }
  }
  Text {
    text: wifiName
    color: wifiName == "Offline" ? shellRoot.red : shellRoot.green
    font {
      family: shellRoot.fontFamily
      pixelSize: shellRoot.fontSize
      bold: true
    }
  }
  MouseArea {
    anchors.fill: parent
    onClicked: networkManagerProc.running = true
  }
}
