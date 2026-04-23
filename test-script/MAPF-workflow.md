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
| **Workflow** | `src/MAPF-workflow.md` |
| **笔记文件夹** | `src/notes/` |
| 实验记录 | `src/notes/EXPERIMENTS/` |
| 创意想法 | `src/notes/IDEAS/` |
| 地图分析 | `src/notes/MAPS/` |
| 研究资料 | `src/notes/RESEARCH/` |
| 代码 | `src/my_planner/` |
| 备份 | `default_planner/` |
| 冠军代码 | `Best-Implementations-2024/` (6个团队) |
| build | `build/lifelong.exe` |

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

## 构建

**构建脚本**: `test-scripts/build.bat`

```batch
# 用法
cd C:\Users\Administrator\Desktop\test-studio-mapf\test-scripts
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

| 文件 | 职责 |
|------|------|
| `src/Entry.cpp` + `inc/Entry.h` | 入口协调 |
| `src/TaskScheduler.cpp` + `inc/TaskScheduler.h` | 任务调度 |
| `src/Executor.cpp` + `inc/Executor.h` | 执行控制 |
| `src/MAPFPlanner.cpp` + `inc/MAPFPlanner.h` | 路径规划 |

---

## 算法实现（src/my_planner/）

| 文件 | 职责 |
|------|------|
| `planner.cpp` | PIBT路径规划 |
| `executor.cpp` | TPG执行控制 |
| `scheduler.cpp` | 贪心调度 |
| `pibt.cpp` | PIBT算法 |
| `flow.cpp` | frank_wolfe流优化 |
| `heuristics.cpp` | 启发式 |

---

## 修改规则

### ✅ 允许
- 优先在 `src/my_planner/` 修改算法
- 在`src`下新增 `.cpp/.h` 文件
- 修改 `CMakeLists.txt`
- 核心接口文件（4个）

### ❌ 禁止
- 修改 `default_planner/`（保持备份）
- 修改 `inc/` 头文件
- 未在允许范围内的其他一切文件

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

详见：`src/notes/EXPERIMENTS/`
