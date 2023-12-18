# https://www.youtube.com/watch?v=2pDSooPLLkI&t=533s

from heapq import heappush, heappop

puzzle = open("C:\\Users\\13390\\Desktop\\我的\\游戏\\MiniMicro\\user.minidisk\\AoC 2023\\day17(python)\\puzzle.txt")
sample = open("C:\\Users\\13390\\Desktop\\我的\\游戏\\MiniMicro\\user.minidisk\\AoC 2023\\day17(python)\\sample.txt")
puzzle = [list(map(int, line.strip())) for line in puzzle]
sample = [list(map(int, line.strip())) for line in sample]

def calculate(puzzle):
    seen = set()
    pq = [(0, 0, 0, 0, 0, 0)]
    
    while pq:
        hl, r, c, dr, dc, n = heappop(pq)
        
        if r == len(puzzle) - 1 and c == len(puzzle[0]) - 1 and n >= 4:
            return(hl)
        
        if (r, c, dr, dc, n) in seen:
            continue
        
        seen.add((r, c, dr, dc, n))
        
        if n < 10 and (dr, dc) != (0, 0):
            nr = r + dr
            nc = c + dc
            if 0 <= nr < len(puzzle) and 0 <= nc < len(puzzle[0]):
                heappush(pq, (hl + puzzle[nr][nc], nr, nc, dr, dc, n + 1))
          
        if n >= 4 or (dr, dc) == (0, 0):
            for ndr, ndc in [(0, 1), (0, -1), (1, 0), (-1, 0)]:
                if (ndr, ndc) != (dr, dc) and (ndr, ndc) != (-dr, -dc):
                    nr = r + ndr
                    nc = c + ndc
                    if 0 <= nr < len(puzzle) and 0 <= nc < len(puzzle[0]):
                        heappush(pq, (hl + puzzle[nr][nc], nr, nc, ndr, ndc, 1))
        
ans = calculate(puzzle)
print(ans)