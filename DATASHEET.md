The following commands have been implemented :

| **Class**              | **Instruction**        | **Meaning** |
|------------------------|-----------------------|------------|
| **Arithmetic**        | add r0, r1, r2        | r0 = r1 + r2 |
|                        | sub r0, r1, r2        | r0 = r1 - r2 |
|                        | addu r0, r1, r2       | r0 = r1 + r2 (unsigned addition, not 2’s complement) |
|                        | subu r0, r1, r2       | r0 = r1 - r2 (unsigned subtraction, not 2’s complement) |
|                        | addi r0, r1, 1000     | r0 = r1 + 1000 |
|                        | addiu r0, r1, 1000    | r0 = r1 + 1000 (unsigned addition, not 2’s complement) |
|                        | madd r0, r1           | r0 * r1 added with the value in the concatenated registers lo and hi. |
|                        | maddu r0, r1          | unsigned version of madd |
|                        | mul r0, r1, r2        | hi = z[63:32], lo = z[31:0], Z = r0 * r1 |
|                        | and r0, r1, r2        | r0 = r1 & r2 |
|                        | or r0, r1, r2         | r0 = r1 | r2 |
|                        | andi r0, r1, 1000     | r0 = r1 & 1000 |
|                        | ori r0, r1, 1000      | r0 = r1 | 1000 |
|                        | not r0, r1            | r0 = ~r1 |
|                        | xori r0, r1, 1000     | r0 = r1 XOR 1000 |
|                        | xor r0, r1, r2        | r = r1 XOR r2 |
|                        | sll r0, r1, 10        | r0 = r1 << 10 (shift left logical) |
|                        | srl r0, r1, 10        | r0 = r1 >> 10 (shift right logical) |
|                        | sla r0, r1, 10        | r0 = r1 << 10 (shift left arithmetic) |
|                        | sra r0, r1, 10        | r0 = r1 >> 10 (shift right arithmetic) |
| **Data Transfer**      | lw r0, 10(r1)         | r0 = Memory[r1 + 10] (load word) |
|                        | sw r0, 10(r1)         | Memory[r1 + 10] = r0 (store word) |
|                        | lui r0, 1000          | r0[31:16] = 1000 |
| **Conditional Branch** | beq r0, r1, 10        | if (r0 == r1) go to PC + 4 + 10 (branch on equal) |
|                        | bne r0, r1, 10        | if (r0 != r1) go to PC + 4 + 10 (branch on not equal) |
|                        | bgt r0, r1, 10        | if (r0 > r1) go to PC + 4 + 10 (branch if greater than) |
|                        | bgte r0, r1, 10       | if (r0 >= r1) go to PC + 4 + 10 (branch if greater than or equal) |
|                        | ble r0, r1, 10        | if (r0 < r1) go to PC + 4 + 10 (branch if less than) |
|                        | bleq r0, r1, 10       | if (r0 <= r1) go to PC + 4 + 10 (branch if less than or equal) |
|                        | bleu r0, r1, 10       | unsigned version of ble |
|                        | bgtu r0, r1, 10       | unsigned version of bgt |
| **Unconditional Branch** | j 10               | jump to address 10 |
|                        | jr r0                 | jump to address stored in register r0 |
|                        | jal 10                | ra = PC + 4 and jump to address 10 |
| **Comparison**         | slt r0, r1, r2        | if (r1 < r2) r0 = 1 else r0 = 0 |
|                        | slti r0, r1, 100      | if (r1 < 100) r0 = 1 else r0 = 0 |
|                        | seq r0, r1, 100       | if (r1 == 100) r0 = 1 else r0 = 0 |
| **Floating Point**     | mfcl r0, f0           | r0 = f0 |
|                        | mtcl f0, r0           | f0 = r0 |
|                        | add.s f0, f1, f2      | f0 = f1 + f2 |
|                        | sub.s f0, f1, f2      | f0 = f1 - f2 |
|                        | c.eq.s cc f0, f1      | The flag cc is set to one if f0 == f1 |
|                        | c.le.s cc f0, f1      | The flag cc is set to one if f0 <= f1 |
|                        | c.lt.s cc f0, f1      | The flag cc is set to one if f0 < f1 |
|                        | c.ge.s cc f0, f1      | The flag cc is set to one if f0 >= f1 |
|                        | c.gt.s cc f0, f1      | The flag cc is set to one if f0 > f1 |
|                        | mov.s cc f0, f1       | f0 = f1 |
--------------------------------------------------------------------------------------

Pseudo-instructions have been condensed to 32 unique instructions.

The final instruction format is as follows:

**I Type** : 

**op**  **func**    **rd**  **rs**  **imm/shamt**

3       2           5       5       16 (1-bit ignored)

**R Type** : 

**op**  **func**    **rd**  **rs**  **rt**

3       2           5       5       5 (12-bits ignored)

**J Type** : 

**op**  **func**    **address**

3       2           27
