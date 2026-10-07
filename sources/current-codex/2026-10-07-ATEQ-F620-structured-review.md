# ATEQ F620 结构化规范与离线实现验收

- 日期：2026-10-07（Asia/Shanghai）。
- 来源：Codex 当前账号；执行代码来自 OpenCode CLI；失败定位/中间审查来自 GPT-6 Luna。
- 用户要求：先输出严格结构化需求、整体状态机、逐步 OK/NG/超时/重试/报警表、伪代码及单元测试用例；再由 OpenCode CLI + DeepSeek V4.1 Flash/max 实现，禁止改变业务逻辑；失败交 GPT-6 Luna/xhigh 定位并修订伪代码，再回同一 OpenCode session。
- GitHub 源仓库：huaweixiong-debug/ATEQ-F620-Laser-2-stations；固定审查提交 c22accdf965bf25ea8b6bca14c10910a6f82d0c9。
- 原目录 Y:\协众\101 ATEQ F620 双腔 + 激光打码 含用户未提交修改；采用独立克隆，66 个原目录文件哈希最终无变化。
- 独立实现目录：C:\Users\Administrator\.codex\opencode-executor\runs\20261007-ateq-f620-spec\workspace；分支 codex/f620-structured-spec。
- 交付：docs/structured_review/requirements.md（22 条规则、16 步流程、12 项发现），pseudocode.md v1.1，test_cases.md v1.1（56 验收项）。
- 修复：打码只用真实已提交 DB 回读并校验，不退过程缓存；Fake 已提交快照隔离；日期方案冻结且贯穿四个 UI 选择入口；激光异常后追加 False 清理且不重发 True；管理员重打权限下沉服务层；提取无 I/O 第一/第二测决策函数。
- 冻结业务：首测非 OK 立即完成；生产双测两 OK 才打码；样件默认首测后结束；不增加自动重测/重打；不猜正负压腔体映射。
- 模型执行：opencode-go/deepseek-v4.1-flash，variant max；session ses_ee94980f7ffes8GYUN2O0xILw0。
- 初次实现后 TC49 的有限假时钟耗尽，未实际到达 done 截止；Luna 修订 P09，采用无限单调假时钟，验证完成位超时原因和写序列 [True, False, False]；同会话返工一次。
- 验证：Python3.10.11，基线64 passed，聚焦207 passed，全套232 passed，simulate smoke exit0；Codex 独立全套232 passed、最终TC49 passed；GPT-6 Luna/xhigh 最终 PASS（0 issues），Codex最终验收 PASS。
- 最终证据：同 run 目录 FINAL_ACCEPTANCE.md；fix-1/REVIEW_PACKET.md；final-review/terra_review.json；F620-structured-implementation.patch。
- 保留风险 AUD05–AUD12：真实模式接受演示管理员口令、UI绕过恢复权限、完成位缺失/旧高位协议、清空定时器竞态/吞错、dual样件pending语义、正负压顺序描述冲突、UI线程跨事务竞态、probe_devices=False仍访问网络/DB。
- 边界：仅离线合成/Fake/Spy/Mock验证；未连接真实设备/生产数据库，未部署；离线 PASS 不代表现场放行；field_release=false。
- GitHub更新（2026-10-07，Codex当前账号）：已把经审查的独立分支推送到 `huaweixiong-debug/ATEQ-F620-Laser-2-stations` 的 `codex/f620-structured-spec`；commit `34bc450f1bdc0936f8c4122c8d9b076354a7bd3c`。原目录的用户未提交修改仍未触碰；未合并到main。
