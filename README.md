# flood-it
Implementation of a grid based colour game using greedy algorithm.
Problem Statement- Flood-it is a combinatorial game played on a coloured graph G whose aim is to make the graph monochromatic using the minimum number of flooding moves, relatively to a fixed pivot, i.e. the upper left corner of the grid.There is a nxn grid, having 6 different colours.
If we try to analyse the problem, we will find out that is a NP-hard problem and hence brute force approach would be very impractical (https://link.springer.com/chapter/10.1007/978-3-319-98355-4_20 - paper on why Flood It! Is a NP- hard problem )

# Greedy Approach 
We hence use a greedy approach where at each step we calculate the next best step by finding out which colour would increase the chain the most. This however gives us a locally optimal solution, hence the point of the game is to try to beat the Greedy algorithm and try to Flood the grid in less than the calculated steps.

## Logic
### Chain Building
The update function builds the chain data member. Chain is a two dimensional array of the size nxn, keeps track of the chain that is formed by the same colours, by storing 1 for part of the chain and 0 for not part of the chain. Using the do while loop, we keep adding the neighbours of the  pre-existing chain, if of the same colour to the chain, the loop terminates when there are no more neighbours, this way all the immediate neighbours and the neighbours' neighbours are also included in the chain.

### Greedy Algorithm
The update function is called for the six possible colour changes at each step and the, the colour change that increases the chain by the max is retained, and the process is continued till the all the elements are a part of the chain, this gives us the minimum steps, or the optimal solution according to Greedy Algorithm (nextStep function and solve function and max function).
Since we have adapted the Greedy Algorithm approach to the problem, the logic does not always provide the globally optimal solution, therefore it is possible to beat the game and solve the grid in less steps than the greedy provided solution.

### Rendering UI
Since controls the pixels of the screen and in the stateful widget it rerenders only the portion of the screen that has been changes, we make changes to the _grid variable and update changes in the setstate() portion of the code, hence only the grid is rerendered, without losing state of the grid. This feature of flutter takes off the load from the processor and hence makes the app more efficient. 
