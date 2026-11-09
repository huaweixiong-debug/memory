# 2026-11-09 小米电视遥控器连接 Windows

来源：Codex 当前账号，本机 Windows 设置和用户现场操作。

- Windows 11 已开启蓝牙，BARROT 蓝牙适配器工作正常。默认扫描未列出小米遥控器，用户确认手机可以搜到「小米蓝牙语音遥控器」。
- 在 Windows 设置 → 蓝牙和其他设备 → 设备，将「蓝牙设备发现」从「默认」切到「高级」后，再进入「添加设备 → 蓝牙」，列表显示「小米蓝牙语音遥控器」或「MI RC」。选中后，Windows 确认「设备已准备就绪」，MI RC 显示「已连接」。
- 遥控器方向键、确认键与语音功能未做实际测试。

## Windows 语音输入核查

- 遥控器以 BLE HID 键盘接入，USB VID/PID 字段为 2717:32B8，PnP REV 0004。GATT 设备信息报告 Realtek BT / Model Xiaomi，固件 1.0.265.1。电池仓 LR03 是电池规格，实体遥控器型号仍未确认。
- Windows 没有给它创建录音端点。唤醒且已连接时，用 WinRT 无缓存完整枚举和定向查询均未发现 ATVV 服务 ab5e0001。订阅三个已枚举的厂商通知特征后，约 30 秒的采样窗口没有数据包；用户报告按了两次语音键。仅统计包长度，无录音。未安装音频桥或虚拟声卡，语音输入未实现。
- 用户手边无原电视或盒子。待续时可根据机身铭牌核对具体型号，或有兼容小米电视/盒子时验证原生语音并通过官方方式检查更新。公开的 RC003 固件 2671 实测支持 ATVV，不代表当前遥控器也支持。

## HID/mSBC 备用语音链路

- 公开项目 mac20777/vibecoding-voice 在相同 VID/PID 2717:32B8 和 BARROT USB 蓝牙适配器上实测过 HID/ATT 通知承载 mSBC，独立于 ATVV；其样机厂商 GATT 服务与本机不同，仍须用本机语音键验证帧。参考 https://github.com/mac20777/vibecoding-voice/blob/main/docs/xiaomi-remote-adaptation-notes.md 。
- 已通过官方发布页下载并核验 Authenticode 签名的 USBPcap 1.5.4.0，安装退出码 0，USBPcap 内核驱动已启动，USB 根设备类 UpperFilters 已登记，但重启前没有可用捕获接口。用户选择保存工作后自行重启。后续先验证捕获接口，限定 BARROT USB 设备，按住语音键测试 mSBC 帧及解码，最后才接语音转写。未安装第三方转写前端，未实测 HID 语音。
