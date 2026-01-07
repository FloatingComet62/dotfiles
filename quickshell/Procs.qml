import Quickshell
import Quickshell.Io
import QtQuick

Scope {
  Timer {
    interval: 2000
    running: true
    repeat: true
    onTriggered: {
      cpuProc.running = true
      memProc.running = true
      brightnessProc.running = true
      volumeProc.running = true
      batteryProc.running = true
      networkProc.running = true
      temperatureProc.running = true
    }
  }

  Process {
    id: cpuProc
    command: ["sh", "-c", "head -1 /proc/stat"]

    stdout: SplitParser {
      onRead: data => {
        var p = data.trim().split(/\s+/)
        var idle = parseInt(p[4]) + parseInt(p[5])
        var total = p.slice(1, 8).reduce((a, b) => a + parseInt(b), 0)
        if (lastCpuTotal > 0) {
          cpuUsage = Math.round(100 * (1 - (idle - lastCpuIdle) / (total - lastCpuTotal)))
        }
        lastCpuTotal = total
        lastCpuIdle = idle
      }
    }
    Component.onCompleted: running = true
  }

  Process {
    id: memProc
    command: ["sh", "-c", "free | grep Mem"]
    stdout: SplitParser {
      onRead: data => {
        var parts = data.trim().split(/\s+/)
        var total = parseInt(parts[1]) || 1
        var used = parseInt(parts[2]) || 0
        memUsage = Math.round(100 * used / total)
      }
    }
    Component.onCompleted: running = true
  }

  Process {
    id: temperatureProc
    command: ["sh", "-c", "~/.config/quickshell/scripts/cpu_temp.sh"]
    stdout: SplitParser {
      onRead: data => {
        cpu_temperature = parseInt(data.trim()) || 0
      }
    }
    Component.onCompleted: running = true
  }

  Process {
    id: brightnessProc
    command: ["sh", "-c", "~/.config/quickshell/scripts/brightness.sh"]
    stdout: SplitParser {
      onRead: data => {
        var parts = data.trim().split(/\s+/)
        brightness = parseInt(parts[0]) || 100
        temperature = parseInt(parts[1]) || 6000
      }
    }
    Component.onCompleted: running = true
  }

  Process {
    id: volumeProc
    command: ["sh", "-c", "wpctl get-volume @DEFAULT_AUDIO_SINK@"]
    stdout: SplitParser {
      onRead: data => {
        var parts = data.trim().split(/\s+/)
        if (parts.length == 3) {
          volume_muted = true;
        } else {
          volume_muted = false;
        }
        volume = (parseFloat(parts[1].trim()) || 0) * 100
      }
    }
    Component.onCompleted: running = true
  }

  Process {
    id: batteryProc
    command: ["sh", "-c", "~/.config/quickshell/scripts/battery.sh"]
    stdout: SplitParser {
      onRead: data => {
        var parts = data.trim().split(/\s+/)
        battery = parseInt(parts[0]) || 0
        batteryCharging = parseInt(parts[1]) || false
      }
    }
    Component.onCompleted: running = true
  }

  Process {
    id: networkProc
    command: ["sh", "-c", "~/.config/quickshell/scripts/network.sh"]
    stdout: SplitParser {
      onRead: data => {
        var parts = data.trim().split(/\s+/)
        wifiName = parts[0];
      }
    }
    Component.onCompleted: running = true
  }
}
