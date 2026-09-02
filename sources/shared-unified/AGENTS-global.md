# AGENTS.md — 工业自动化 + AI 推理平台

> 本文件专为 DeepSeek V4-Pro 在 Codex 中优化。目标是弥补与 Opus 4.7 在 Agent 编排和多文件重构上的差距。

---

## 一、IMPORTANT — 核心行为规则

### 任务执行纪律
- **YOU MUST** 在开始任何非平凡任务前先读相关文件，不要凭记忆写代码
- **YOU MUST** 每次只改一个关注点，改完验证后再进行下一个改动
- **YOU MUST** 写代码前先用 `grep` 搜索项目中的现有模式和命名约定，保持一致性
- **IMPORTANT**: 涉及硬件通信协议的代码，不要假设设备行为 — 先读设备文档或现有驱动代码
- **IMPORTANT**: 修改数据库 schema 或查询前，先读 migration 文件和现有 model 定义
- **IMPORTANT**: YOLO 推理相关代码改动后，提醒用户在实际硬件上验证推理延迟和精度

### 禁止行为
- **DO NOT** 在同一个 commit 里混合前端 UI 改动和后端协议改动 — 分开提交
- **DO NOT** 给 Modbus/RS232/RS485 通信代码添加重试逻辑时自作主张 — 先确认设备的容错特性
- **DO NOT** 猜测数据库字段类型 — 必须查 schema 文件或 migration
- **DO NOT** 使用 `rm` 删除文件，总是先确认

---

## 二、项目架构约定

### 目录结构（请根据实际项目调整）
```
src/
├── web/          # 前端 UI（React/Vue/Next.js）
├── server/       # 后端 API 服务
├── devices/      # 设备驱动层（TCP/Modbus/RS232/RS485）
├── inference/    # YOLOv26 推理引擎
├── robot/        # 机器人控制
├── db/           # 数据库 migrations 和 models
└── shared/       # 前后端共享类型和工具函数
```

### 架构决策记录
- **前后端通信**: REST API（或 WebSocket），不要在 Web UI 里直接调用设备驱动
- **设备驱动层**: 每种协议（Modbus/RS232/RS485/TCP）有独立的抽象层，上层业务不直接操作串口
- **YOLO 推理**: 推理服务独立进程，通过消息队列或 HTTP 与主服务通信
- **数据库**: 生产数据走时序数据库或 PostgreSQL，不存 SQLite（除非是本地缓存）
- **机器人控制**: 所有机器人指令有超时和紧急停止机制，不能有无限等待

---

## 三、常用命令

### 开发环境启动
```bash
# 前端开发服务器
cd src/web && npm run dev        # 或 yarn dev / pnpm dev

# 后端开发服务器
cd src/server && python main.py  # 或 go run . / cargo run

# 推理服务
cd src/inference && python server.py

# 数据库迁移
cd src/db && python manage.py migrate   # 或 alembic upgrade head
```

### 测试
```bash
# 运行所有测试
pytest                           # 或 npm test / go test ./...

# 运行特定模块测试（IMPORTANT: 设备驱动测试可能需要实际硬件）
pytest tests/devices/ -v        # 设备驱动测试
pytest tests/inference/ -v      # 推理测试（可能使用模拟权重）

# 前端测试
cd src/web && npm run test -- --watch=false

# 单个测试文件
pytest tests/devices/test_modbus.py::test_read_holding_registers -v
```

### 代码质量
```bash
# 格式化 & Lint
ruff check src/                  # Python
cd src/web && npx eslint .       # 前端
golangci-lint run ./...          # Go

# 类型检查
mypy src/                        # Python
cd src/web && npx tsc --noEmit   # TypeScript
```

### 构建
```bash
# 前端构建
cd src/web && npm run build

# 打包
docker build -t project-name .
```

---

## 四、代码风格与命名规范

### Python（设备驱动 / 推理 / 后端）
- 设备驱动类命名: `{Protocol}{Device}Driver`（例如 `ModbusPLCDriver`、`RS232SensorDriver`）
- 所有 I/O 操作必须有 timeout 参数，默认值 5 秒
- 异常处理: 设备层抛 `DeviceError`/`CommunicationError`，服务层捕获并转换为业务异常
- 日志: 使用 `logging.getLogger(__name__)`，设备通信日志用 DEBUG 级别
- 类型注解: 所有公共函数必须有完整的类型注解

### 前端（Web UI）
- 组件命名: PascalCase，文件名与组件名一致
- 状态管理: 设备状态走全局 store，UI 状态走组件局部 state
- API 调用: 统一走 `src/web/src/api/` 下的模块，不要在组件里直接 fetch
- 错误处理: 每个 API 调用必须有 `.catch()` 或 try-catch，显示用户可理解的错误信息

### 通用
- 变量命名: 不要用缩写，除非是行业通用缩写（如 `rpm`、`pid`、`gpio`）
- 魔法数字: 必须定义为命名常量，尤其是寄存器地址、串口参数、超时时间
- 注释: 解释「为什么」，不是「做什么」。硬件相关的特殊处理必须有注释说明

---

## 五、关键领域专有规则

### 设备通信协议
- **IMPORTANT**: Modbus 地址从 1 开始不是 0，代码中的 offset 要注释清楚
- **IMPORTANT**: RS232/RS485 打开端口后必须设置正确的 baud_rate、parity、stop_bits、byte_size
- **IMPORTANT**: TCP 设备连接必须有心跳和断线重连机制
- 串口操作必须在 `try/finally` 中关闭端口
- 设备响应超时时间根据实际设备调整，默认不要太短（工业设备响应慢）

### YOLOv26 推理
- **IMPORTANT**: 推理代码需要区分 warm-up 阶段和正式推理阶段
- 图像预处理步骤必须与训练时的预处理一致
- 推理结果包含 bbox 坐标时，注明坐标系（像素坐标 / 归一化坐标）
- 模型权重路径: 使用配置文件，不要硬编码
- GPU 显存管理: 不推理时释放显存或使用共享内存

### 机器人控制
- **IMPORTANT**: 所有运动指令必须有安全边界检查
- 紧急停止逻辑: 最高优先级，不能被任何其他逻辑阻塞
- 指令队列: 先进先出，支持清空队列操作
- 状态上报: 机器人状态变化必须推送到前端（WebSocket 或 SSE）

### 数据库
- 生产数据表: 按时间分区，保留策略在配置中定义
- 敏感数据（设备密码、API Key）: 不在数据库中明文存储
- Migration 文件: 不可逆的操作（DROP TABLE/COLUMN）需要注释确认

---

## 六、任务执行指南（弥补 DeepSeek Agent 能力差距）

### 复杂多文件任务 — Superpowers 工作流

当任务涉及 3 个以上文件或需要跨模块改动时：
1. **先用 `/superpowers:brainstorm`** — 理清需求、边界条件和潜在坑点
2. **再用 `/superpowers:writing-plans`** — 产出分步实施计划，每步只涉及 1-2 个文件
3. **再用 `/superpowers:executing-plans`** — 按计划逐步执行，不跳步
4. **最后 `/superpowers:verification-before-completion`** — 整体自查，跑测试，确认无误

### 新功能开发 — 先读再写
1. 读 2-3 个类似功能的现有代码作为参考
2. 确认模式和约定后才开始写新代码
3. 写完后对照参考代码自检一致性

### 调试硬件相关问题
1. 先读设备驱动代码和日志
2. 不要假设是代码 bug — 硬件问题（接线、配置、固件）同样常见
3. 建议添加调试日志而不是直接修改业务逻辑

---

## 七、常见陷阱与注意事项

1. **Modbus 字节序**: 不同设备可能用 Big-Endian 或 Little-Endian，读取寄存器后注意字节序转换
2. **串口独占**: 同一串口不能被多个进程同时打开，检查是否有残留进程
3. **YOLO 输入尺寸**: 推理输入尺寸必须与模型导出时一致，否则结果会偏移
4. **时间戳**: 设备数据和生产数据的时间戳统一使用 UTC，前端展示时转换
5. **竞态条件**: 机器人指令和传感器读取可能并发，注意加锁
6. **前端轮询**: 不要用 setInterval 高频轮询设备状态，用 WebSocket 推送

## 八、默认 Codex/OpenCode 协作路由

对代码修改需求，默认使用用户级 `$opencode-executor`：当前 Codex（通常为 GPT-5.6 Sol）只负责首次详细规划和一次最终验收，OpenCode（默认 `opencode-go/mimo-v2.5`/`none`）负责实际编辑并生成 `REVIEW_PACKET.md`；简单任务由临时只读 GPT-5.6 Luna/high 中间审核，复杂任务由 GPT-5.6 Terra/high 中间审核；最多由同一 OpenCode session 返工一次。用户明确说“Codex 直接执行”时才绕过该路由；不要启动 AutoFlow 页面或让 Sol 反复扫描整个项目。
