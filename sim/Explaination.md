# Matrices Multiplication

## Matrices:

𝐴 = 
9|8|7
-|-|-
6|5|4
3|2|1

𝐵 = 
1|9|8
-|-|-
7|6|5
4|3|2


## Resulting Matrix 𝐶:

𝐶[0][0] = (9 * 1) + (8 * 7) + (7 * 4) = 93  
𝐶[0][1] = (9 * 9) + (8 * 6) + (7 * 3) = 150  
𝐶[0][2] = (9 * 8) + (8 * 5) + (7 * 2) = 126  
𝐶[1][0] = (6 * 1) + (5 * 7) + (4 * 4) = 57  
𝐶[1][1] = (6 * 9) + (5 * 6) + (4 * 3) = 96  
𝐶[1][2] = (6 * 8) + (5 * 5) + (4 * 2) = 81  
𝐶[2][0] = (3 * 1) + (2 * 7) + (1 * 4) = 21  
𝐶[2][1] = (3 * 9) + (2 * 6) + (1 * 3) = 42  
𝐶[2][2] = (3 * 8) + (2 * 5) + (1 * 2) = 36  

So, the result matrix 𝐶 is:

𝐶 = 
93|150|126
-|-|-
57|96|81
21|42|36


Now, let's convert these decimal values to hexadecimal:

- 𝐶[0][0] = 93 (0x5D)
- 𝐶[0][1] = 150 (0x96)
- 𝐶[0][2] = 126 (0x7E)
- 𝐶[1][0] = 57 (0x39)
- 𝐶[1][1] = 96 (0x60)
- 𝐶[1][2] = 81 (0x51)
- 𝐶[2][0] = 21 (0x15)
- 𝐶[2][1] = 42 (0x2A)
- 𝐶[2][2] = 36 (0x24)

So, the result matrix 𝐶 in hexadecimal format is:

𝐶 = 
5D|96|7E
-|-|-
39|60|51
15|2A|24


The 1-D array representation of this matrix in hexadecimal (with 8 bits for each element) will be:

𝐶 = 5D967E396051152A24
