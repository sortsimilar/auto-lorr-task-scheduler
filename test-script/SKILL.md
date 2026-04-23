---
name: big-experiment
description: 大实验强制模式。当需要进行重大架构改动、深度研究、或任何需要2小时以上专注的工作时触发此skill。触发词："大实验"、"深度研究"、"架构改动"、"做大事"、"我不指挥了"。
---

# Big Experiment Mode - 大实验强制模式

## ⚠️ 核心路径（死记！）

| 用途 | 绝对路径 |
|------|----------|
| **项目根目录** | `C:\Users\Administrator\Desktop\test-studio-mapf\LORR26_842072627` |
| **笔记文件夹** | `C:\Users\Administrator\Desktop\test-studio-mapf\LORR26_842072627\src\notes` |
| **实验记录** | `src\notes\EXPERIMENTS\` |
| **创意想法** | `src\notes\IDEAS\` |
| **地图分析** | `src\notes\MAPS\` |
| **研究资料** | `src\notes\RESEARCH\` |
| **工作流文档** | `src\MAPF-workflow.md` |
| **代码目录** | `src\my_planner\` |
| **测试脚本** | `C:\Users\Administrator\Desktop\test-studio-mapf\test-scripts\` |
| **build输出** | `build\lifelong.exe` |
| **冠军代码** | `C:\Users\Administrator\Desktop\test-studio-mapf\Best-Implementations-2024\` |

---

## ⚠️ 2026-04-22 惨痛教训

### 问题总结
1. **实验记录零散** - A76-A111 几乎没有记录，2小时工作无据可查
2. **全量测试浪费** - 频繁测全部7个地图，浪费时间
3. **参数调优过度** - 2小时+在参数上，算法丝毫没有改进
4. **没有统一配置** - frank_wolfe 的 deadline_per_agent 硬编码

### 立即整改
- 见 `mapf-experiment-discipline` skill 的完整整改方案
- **每个实验必须有记录**
- **使用统一配置函数**
- **优先算法突破**

---

## 核心原则

### 第一手资料优先于二手解读
> **官网文档、比赛规则是根本。不要基于"据说"或"我想"做判断**

### 笔记规则（死记！）
1. **所有想法必须写进 `src/notes/`**，不许留在别处
2. **每次实验后立即记录**，不许"之后再写"
3. **每个实验一个文件**：`A__.md`
4. **笔记按类别归档**：
   - `EXPERIMENTS/` - 实验记录 (A42.md, A44.md...)
   - `IDEAS/` - 创意想法 (delay-strategy.md...)
   - `MAPS/` - 地图分析 (random.md, fulfill.md...)
   - `RESEARCH/` - 研究资料 (champion-teams.md...)
5. **查看笔记先看 INDEX.md**

---

## 时间分配优先级（强制）

| 优先级 | 活动 | 时间比例 | 说明 |
|--------|------|----------|------|
| **P0** | 算法突破（LNS/SIPP/LaCAM2） | **60%** | 最高ROI |
| P1 | 单地图参数微调 | 20% | 低ROI，已几乎到顶 |
| P2 | 系统化实验框架 | 10% | 防止未来浪费 |
| P3 | 全量验证 | 10% | 每天1-2次足够 |

**规则**：
- 连续3次参数调优 → 强制转向算法研究
- 参数调优达到20%时间上限 → 强制转向算法

---

## 统一配置函数（强制要求）

所有地图特定的配置必须通过统一的配置函数获取：

```cpp
// map_config.h - 统一的地图配置结构
struct MapConfig {
    int pibt_runtime;              // pibt 时间参数
    int traffic_tolerance;         // traffic flow tolerance
    bool use_frank_wolfe;          // 是否使用 frank_wolfe
    bool use_my_planner;           // 使用 MyPlanner 还是 DefaultPlanner
    int fw_deadline_per_agent;     // frank_wolfe 每次迭代的 deadline
};

// 统一的配置获取函数（必须用这个！）
MapConfig get_map_config(SharedEnvironment* env);
```

---

## 固定沉淀文件

| 文件 | 职责 |
|------|------|
| `src/notes/INDEX.md` | 笔记索引 |
| `src/notes/EXPERIMENTS/*.md` | 实验记录 |
| `src/notes/IDEAS/core-strategies.md` | 核心策略 |
| `src/notes/MAPS/all-maps.md` | 地图分析 |
| `src/notes/RESEARCH/champion-teams.md` | 冠军分析 |
| `MEMORY.md` | 长期记忆 |

---

## 知识沉淀规则

### RESEARCH-notes.md必须包含的板块
1. **已验证事实** — 不可逆的结论
2. **架构差距图谱** — 当前vs冠军的对比
3. **灾难性失败记录** — 永远不要再试的方向
4. **当前最佳** — 最高分commit和分数
5. **下一步候选** — 下一个A方向

---

## 单地图调优流程（强制执行）

```
1. 明确假设：预期X变化会发生，因为Y原因
2. 确定成功标准：分数从___提升到___
3. 确定测试上限：最多测N次
4. 只测目标地图（用单独的测试脚本）
5. 记录到 src/notes/EXPERIMENTS/A__.md
6. 立即 commit（无论成功失败）
7. 可选：验证其他1-2个关键地图不受影响
8. 全量测试：每天只做1-2次
```

---

## 自动迭代规则

```
LOOP (大实验循环):
  1. 从A方向开始（优先算法研究 P0）
  2. 研究 → 写到src/notes/ → 验证理解
  3. 执行PRE-EXPERIMENT-CHECKLIST
  4. 建造 + 测试 + milestone记录
  5. IF 失败:
       - 深度反思：为什么失败？
       - 记录失败原因到src/notes/EXPERIMENTS/
       - 如果是参数调优失败 → 立即转向算法研究
  6. 继续LOOP
END
```

---

## 预检查清单

```
实验名称: _______________
时间: _______________
笔记路径: src/notes/EXPERIMENTS/A__.md

当前阶段：P0(算法)/P1(参数)/P2(框架)/P3(验证)

假设:
1. ________________________________
2. ________________________________

成功标准:
- 分数从 ___ 提升到 ___

测试上限:
- 最多测 ___ 次
- 如果参数调优超过20%时间 → 强制转向算法

失败结论:
- 如果失败，说明 ___
```

---

## 版本历史

- 2026-04-22 16:42: 添加时间分配优先级、统一配置函数要求、单地图调优流程
- 2026-04-22 12:04: 添加统一笔记系统 src/notes/
- 2026-04-21 16:20: 添加"为什么总是选D"自我诊断
- 2026-04-21 14:20: 嵌入"研究与代码并重"原则
- 2026-04-21 12:15: 嵌入"不逃避原则"、"反思思维规则"
