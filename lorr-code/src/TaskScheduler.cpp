#include "TaskScheduler.h"

#include <algorithm>
#include <cctype>
#include "scheduler.h"
#include "const.h"

// ============================================================================
// Map-aware scheduler routing
// ============================================================================
// Returns true if env->map_name contains the given substring (case-insensitive)
static bool map_contains(const SharedEnvironment* env, const char* substr) {
    if (env == nullptr || env->map_name.empty()) return false;
    std::string name = env->map_name;
    std::transform(name.begin(), name.end(), name.begin(), ::tolower);
    std::string pat = substr;
    std::transform(pat.begin(), pat.end(), pat.begin(), ::tolower);
    return name.find(pat) != std::string::npos;
}

// Returns true for warehouse/fulfill maps (our primary optimization target)
static bool is_warehouse_map(const SharedEnvironment* env) {
    return map_contains(env, "warehouse") || map_contains(env, "fulfill");
}

// Returns true for large open maps (random, room)
static bool is_open_map(const SharedEnvironment* env) {
    return map_contains(env, "random") || map_contains(env, "room");
}

/**
 * Initializes the task scheduler with a given time limit for preprocessing.
 * 
 * This function prepares the task scheduler by allocating up to half of the given preprocessing time limit 
 * and adjust for a specified tolerance to account for potential timing errors. 
 * It ensures that initialization does not exceed the allocated time.
 * 
 * @param preprocess_time_limit The total time limit allocated for preprocessing (in milliseconds).
 *
 */
void TaskScheduler::initialize(int preprocess_time_limit)
{
    //give at most half of the entry time_limit to scheduler;
    //-SCHEDULER_TIMELIMIT_TOLERANCE for timing error tolerance
    int limit = preprocess_time_limit/2 - DefaultPlanner::SCHEDULER_TIMELIMIT_TOLERANCE;

    if (is_warehouse_map(env)) {
        // TODO: Custom warehouse scheduler init
        return;
    }

    DefaultPlanner::schedule_initialize(limit, env);
}

/**
 * Plans a task schedule within a specified time limit.
 * 
 * This function schedules tasks by calling shedule_plan function in default planner with half of the given time limit,
 * adjusted for timing error tolerance. The planned schedule is output to the provided schedule vector.
 * 
 * @param time_limit The total time limit allocated for scheduling (in milliseconds).
 * @param proposed_schedule A reference to a vector that will be populated with the proposed schedule (next task id for each agent).
 */

void TaskScheduler::plan(int time_limit, std::vector<int> & proposed_schedule)
{
    //give at most half of the entry time_limit to scheduler;
    //-SCHEDULER_TIMELIMIT_TOLERANCE for timing error tolerance
    int limit = time_limit/2 - DefaultPlanner::SCHEDULER_TIMELIMIT_TOLERANCE;

    if (is_warehouse_map(env)) {
        // TODO: Custom warehouse scheduler - use default for now
        DefaultPlanner::schedule_plan(limit, proposed_schedule, env);
        return;
    }

    DefaultPlanner::schedule_plan(limit, proposed_schedule, env);
}
