# Linux System Health Monitor
A Bash-based automation tool to monitor system resources (CPU, RAM, Disk) and log alerts when thresholds are exceeded.

## 🚀 Features
- **Real-time Monitoring:** Tracks CPU, Memory, and Disk usage.
- **Automated Logging:** Saves alerts with timestamps to a log file.
- **Lightweight:** Minimal system footprint, perfect for servers.

## 🛠️ Tech Stack
- **OS:** Linux (Developed on CachyOS/Arch)
- **Language:** Bash Scripting
- **Tools:** awk, sed, top, df, free

## 📂 Project Structure
- `scripts/`: Contains the main health monitor script.
- `logs/`: (Ignored by Git) Local directory for system logs.

## ⚙️ Usage
1. Clone the repo: `git clone https://github.com/Aniketchavan14/linux-system-monitor.git`
2. Give execution permissions: `chmod +x scripts/system_monitor.sh`
3. Run the script: `./scripts/system_monitor.sh`

## Tested on CachyOS
Environment: Developed on CachyOS (Arch-based) utilizing the Bore Kernel for optimized performance.

## ⏰ Automation (Deployment)
To automate this script on a production server, use **Crontab**. 
1. Open crontab: `crontab -e`
2. Add the following line to run the monitor every hour:
   `0 * * * * cd /home/username/linux-system-monitor && ./scripts/system_monitor.sh`
