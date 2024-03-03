#!/usr/bin/env python
# coding: utf-8

# In[1]:


from collections import deque

def pour(Jug1, Jug2):
    return max(Jug1 - (Jug2[1] - Jug2[0]), 0), min(Jug1 + Jug2[0], Jug2[1])

def water_jug_solver(a, b, target):
    visited = set()
    queue = deque([((0, 0), [])])
    
    while queue:
        (jug1, jug2), steps = queue.popleft()
        if (jug1, jug2) in visited:
            continue
        if jug1 == target:
            return steps, len(steps)
        
        visited.add((jug1, jug2))
        
        queue.append(((a, jug2), steps + ['Fill Jug1']))
        queue.append(((jug1, b), steps + ['Fill Jug2']))
        queue.append(((0, jug2), steps + ['Empty Jug1']))
        queue.append(((jug1, 0), steps + ['Empty Jug2']))
        new_jug1, new_jug2 = pour(jug1, (jug2, b))
        queue.append(((new_jug1, new_jug2), steps + ['Pour Jug1 to Jug2']))
        new_jug2, new_jug1 = pour(jug2, (jug1, a))
        queue.append(((new_jug1, new_jug2), steps + ['Pour Jug2 to Jug1']))
    
    return "No solution.", 0 

solution, steps_count = water_jug_solver(4, 3, 2)
print("Solution steps:", solution)
print("Total steps taken:", steps_count)


# In[2]:


from collections import deque

def is_valid(state):
    missionaries_left, cannibals_left, boat, missionaries_right, cannibals_right = state
    if missionaries_left < 0 or missionaries_right < 0 or cannibals_left < 0 or cannibals_right < 0:
        return False 
    if missionaries_left < cannibals_left and missionaries_left > 0: return False
    if missionaries_right < cannibals_right and missionaries_right > 0: return False
    return True  

def get_successors(state):
    successors = []
    moves = [(1, 0), (2, 0), (0, 1), (0, 2), (1, 1)]
    missionaries_left, cannibals_left, boat, missionaries_right, cannibals_right = state
    
    for m, c in moves:
        if boat == 'left':
            new_state = (missionaries_left - m, cannibals_left - c, 'right', missionaries_right + m, cannibals_right + c)
        else:
            new_state = (missionaries_left + m, cannibals_left + c, 'left', missionaries_right - m, cannibals_right - c)
        
        if is_valid(new_state):
            action = f"Move {m} missionaries and {c} cannibals from {'left' if boat == 'left' else 'right'} to {'right' if boat == 'left' else 'left'}"
            successors.append((new_state, action))
    
    return successors

def bfs():
    initial_state = (3, 3, 'left', 0, 0)
    goal_state = (0, 0, 'right', 3, 3)
    frontier = deque([((initial_state, ""), [])])
    explored = set()
    
    while frontier:
        (current_state, action), path = frontier.popleft()
        if current_state in explored:
            continue
        explored.add(current_state)
        
        new_path = path + [action] if action else path
        
        if current_state == goal_state:
            return new_path
        
        for successor, action in get_successors(current_state):
            if successor not in explored:
                frontier.append(((successor, action), new_path))
    
    return None

solution_path = bfs()
for step in solution_path:
    print(step)


# In[ ]:




