# MAPF 工作流

---

## ⚠️ 重要提醒

1. **云端冠军不是一个！** 有6个团队的代码，每个用不同算法
2. **笔记全部在 `src/notes/`**，不许到处留
3. **地图判断用字符串包含**，不许写死地图名
4. **分数公式**: `score = numTaskFinished / makespan`

---

## 项目结构

| 文件 | 路径 |
|------|------|
| **Workflow** | `C:\gitcloud\auto-lorr-new\lorr-code\src\MAPF-workflow.md` |
| **笔记文件夹** | `C:\gitcloud\auto-lorr-new\lorr-code\src\notes` |
| 实验记录 | `C:\gitcloud\auto-lorr-new\lorr-code\src\notes\EXPERIMENTS` |
| 创意想法 | `C:\gitcloud\auto-lorr-new\lorr-code\src\notes\IDEAS` |
| 地图分析 | `C:\gitcloud\auto-lorr-new\lorr-code\src\notes\MAPS` |
| 研究资料 | `C:\gitcloud\auto-lorr-new\lorr-code\src\notes\RESEARCH` |
| 代码 | `C:\gitcloud\auto-lorr-new\lorr-code\src` |
| 备份 | `C:\gitcloud\auto-lorr-new\lorr-code\default_planner` |
| **冠军代码** | `C:\gitcloud\auto-lorr-new\Best-Implementations-2024` (6个团队) |
| build | `C:\gitcloud\auto-lorr-new\lorr-code\build\lifelong.exe` |
| **测试脚本** | `C:\gitcloud\auto-lorr-new\test-script` |

---

## 路径修复说明

- 原指向 `C:\Users\Administrator\Desktop\test-studio-mapf\` 的路径 → `C:\gitcloud\auto-lorr-new\test-script`
- `test-scripts/build.bat` → `C:\gitcloud\auto-lorr-new\test-script\build.bat`
- 冠军代码统一在 `C:\gitcloud\auto-lorr-new\Best-Implementations-2024`

---

## 构建

**构建脚本**: `C:\gitcloud\auto-lorr-new\test-script\build.bat`

```batch
cd C:\gitcloud\auto-lorr-new\test-script
build.bat
```

**注意**: 使用 Python311 (C:\Python311) 进行构建，避免 Python3.14 + MinGW 链接问题。

---

## 测试脚本

### 独立测试脚本（每个地图一个）
| 脚本 | 地图 | 输出目录 |
|------|------|----------|
| `run_random_md5.ps1` | random | random_round/ |
| `run_bos_md5.ps1` | bos | bos_round/ |
| `run_room_md5.ps1` | room | room_round/ |
| `run_maze_md5.ps1` | maze | maze_round/ |
| `run_fulfill_md5.ps1` | fulfill | fulfill_round/ |
| `run_orz_md5.ps1` | orz | orz_round/ |
| `run_iron_md5.ps1` | iron | iron_round/ |

### 其他脚本
| 脚本 | 用途 |
|------|------|
| `run_mini_md5.ps1` | 默认测试 (random + fulfill) |
| `run_quick_test_md5.ps1` | 全地图测试 (7个地图) |
| `build.bat` | 构建 lifelong.exe |

### 源码MD5检测
所有脚本使用源码MD5检测，不变则用缓存。

---

## 地图判断方式

```cpp
// ✅ 正确：字符串包含判断
std::string name = env->map_name;
std::transform(name.begin(), name.end(), name.begin(), ::tolower);
if (name.find("room") != std::string::npos) { ... }

// ❌ 错误：写死地图名
if (map_name == "room") { ... }
```

---

## 核心接口文件（4个）

| 文件 | 路径 | 职责 |
|------|------|------|
| `src/Entry.cpp` + `inc/Entry.h` | `C:\gitcloud\auto-lorr-new\lorr-code\src\` | 入口协调 |
| `src/TaskScheduler.cpp` + `inc/TaskScheduler.h` | `C:\gitcloud\auto-lorr-new\lorr-code\src\` | 任务调度 |
| `src/Executor.cpp` + `inc/Executor.h` | `C:\gitcloud\auto-lorr-new\lorr-code\src\` | 执行控制 |
| `src/MAPFPlanner.cpp` + `inc/MAPFPlanner.h` | `C:\gitcloud\auto-lorr-new\lorr-code\src\` | 路径规划 |

---

## Schedule方向可改的文件（官方Schedule Track规则）

根据 `Evaluation_Environment.md`，**Schedule Track** 规则：

### ✅ 允许修改
| 文件 | 说明 |
|------|------|
| `src/TaskScheduler.cpp` | **核心**：任务调度算法（唯一确定可改的调度文件） |
| `inc/TaskScheduler.h` | 调度器接口 |
| `CMakeLists.txt` | 构建配置 |
| `src/` 下新建 `.cpp/.h` | 可自由创建新模块 |
| `python/` | Python实现（除 `__init__.py` 和 `common/*` 外） |

### ❌ Schedule Track禁止修改
```
inc/MAPFPlanner.h, src/MAPFPlanner.cpp    # Planner文件禁止
inc/Entry.h, src/Entry.cpp                 # Entry入口禁止
inc/Executor.h, src/Executor.cpp          # Executor禁止
inc/Plan.h                                 # Plan接口禁止

# 任何track都禁止的核心系统文件：
src: ActionModel.cpp, Evaluation.cpp, Logger.cpp, States.cpp, driver.cpp,
     CompetitionSystem.cpp, Grid.cpp, common.cpp, TaskManager.cpp, Simulator.cpp, DelayGenerator.cpp
inc: ActionModel.h, Evaluation.h, Logger.h, SharedEnv.h, Tasks.h, CompetitionSystem.h, Grid.h,
     States.h, common.h, TaskManager.h, Simulator.h, DelayGenerator.h, Counter.h, Delay.h, Plan.h,
     nlohmann/json.hpp, nlohmann/json_fwd.hpp
default_planner/*                          # 全部禁止
python/__init__.py, python/common/*        # 禁止
```

### ⚠️ 重要澄清
- `Entry.cpp` / `Executor.cpp` 在Schedule Track是**禁止**修改的！
- `default_planner/scheduler.cpp`、`heuristics.cpp`、`const.h` 都在 `default_planner/*` 下，**全部禁止修改**
- 如果需要改 Entry/Executor 逻辑 → 需要切换到 **Combined Track**

### Schedule改进策略
由于Schedule Track只能改 `TaskScheduler.cpp`，核心策略：
1. 在 `TaskScheduler.cpp` 内实现更智能的调度算法（如LNS）
2. 充分利用 `env` 暴露的信息（task_pool, goal_locations, curr_task_schedule）
3. 借鉴 Team_RAPID 的 LNS 思路但在 TaskScheduler.cpp 内实现

---

## 修改规则

### ✅ 允许
- 优先在 `src/my_planner/` 修改算法（如果需要新建）
- 在`src`下新增 `.cpp/.h` 文件
- 修改 `CMakeLists.txt`
- 核心接口文件（4个）+ Schedule方向文件

### ❌ 禁止
- 修改 `default_planner/`（保持备份）
- 修改 `inc/` 头文件（除 TaskScheduler.h 外）
- 指定的 unmodifiable 文件（见 Evaluation_Environment.md）

---

## 冠军团队（不只一个！）

| 团队 | 算法 | Random配置 |
|------|------|------------|
| Team_Kitty_Knight | CausalPIBT + PLNS | causal_pibt |
| **Team_RAPID** | **LNS + LaCAM2** | **LNS** |
| Team_No_Man_Sky (3版本) | 待研究 | 待研究 |
| Team_SYSU-LCIS | 待研究 | 待研究 |

**Team_RAPID 对 random 使用 LNS 算法！**

---

## 当前分数 (commit 3f1c635)

| 地图 | 分数 | Planner | frank_wolfe |
|------|------|---------|-------------|
| random | 0.52 | DefaultPlanner | N/A |
| bos | 0.31 | DefaultPlanner | N/A |
| room | 0.15 | MyPlanner | ❌跳过 |
| maze | 0.09 | MyPlanner | ❌跳过 |
| fulfill | 1.07 | MyPlanner | ✅ |
| orz | 0.22 | MyPlanner | ❌跳过 |
| iron | 0.15 | MyPlanner | ❌跳过 |
| **Total** | **2.50** | - | - |

---

## 已验证策略

| 实验 | 描述 | 结果 |
|------|------|------|
| A42 | 跳过frank_wolfe for tight maps | ✅ |
| A44 | Random tie-breaking | ✅ |
| A45 | MyPlanner for random | ❌崩溃 |
| A46 | MIN_PIBT_TIME=100 | ❌变差 |
| A47 | frank_wolfe skip for random | ❌变差 |

详见：`C:\gitcloud\auto-lorr-new\lorr-code\src\notes\EXPERIMENTS`

---

## 固定沉淀文件

| 文件 | 路径 |
|------|------|
| `src/notes/INDEX.md` | 笔记索引 |
| `src/notes/EXPERIMENTS/*.md` | 实验记录 |
| `src/notes/IDEAS/core-strategies.md` | 核心策略 |
| `src/notes/MAPS/all-maps.md` | 地图分析 |
| `src/notes/RESEARCH/champion-teams.md` | 冠军分析 |
| `MEMORY.md` | 长期记忆 |

---

## 笔记规则（死记！）

1. **所有想法必须写进 `src/notes/`**，不许留在别处
2. **每次实验后立即记录**，不许"之后再写"
3. **笔记按类别归档**：
   - `EXPERIMENTS/` - 实验记录 (A42.md, A44.md...)
   - `IDEAS/` - 创意想法 (delay-strategy.md...)
   - `MAPS/` - 地图分析 (random.md, fulfill.md...)
   - `RESEARCH/` - 研究资料 (champion-teams.md...)
4. **查看笔记先看 INDEX.md**

---

## 时间分配优先级（强制）

| 优先级 | 活动 | 时间比例 | 说明 |
|--------|------|----------|------|
| **P0** | 算法突破（LNS/SIPP/LaCAM2） | **60%** | 最高ROI |
| P1 | 单地图参数微调 | 20% | 低ROI，已几乎到顶 |
| P2 | 系统化实验框架 | 10% | 防止未来浪费 |
| P3 | 全量验证 | 10% | 每天1-2次足够 |

---

## 版本历史

- 2026-04-23: 路径修复，添加Schedule方向可改文件清单，添加冠军代码位置
- 2026-04-22: 添加时间分配优先级、统一配置函数要求、单地图调优流程
- 2026-04-22: 添加统一笔记系统 src/notes/
