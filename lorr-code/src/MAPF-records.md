# MAPF 调试记录

## 云端崩溃问题 (2026-04-21 21:00)

### 症状
- 云端room-B评估崩溃，Exit Code 139 (SIGSEGV段错误)
- 本地测试room地图：程序运行但极慢，最终超时

### 调查过程
1. 本地测试确认：room/maze地图运行极慢，40个timetick后就一直timeout
2. iron地图：10000 agents，全部timeout，0任务完成
3. random/fulfill/bos/orz：正常工作

### 根因分析
1. **云端崩溃**：可能是云端评估超时被杀，或实际SIGSEGV
2. **本地超时**：planner太慢，每步都timeout

### 当前状态
- commit 0ccafe7: WIP - room超时问题
- A14代码(3ae0134): total=1.668，本地random=0.523, fulfill=1.097
- room地图：无输出（程序被kill或运行极慢）

### 待解决
1. 确认云端崩溃是超时还是实际SIGSEGV
2. 优化planner性能，解决room/maze超时问题
3. 考虑为不同地图设置不同参数
