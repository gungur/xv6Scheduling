#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "pstat.h"


int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return myproc()->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

// Set the number of tickets for the calling process.
int
sys_settickets(void)
{
  int n;
  // Get the number of tickets from the argument.
  if (argint(0, &n) < 0)
    return -1;

  // Define ticket boundaries
  if (n < 1) {
    n = 8;  // Set default if less than minimum
  } else if (n > (1 << 5)) {
    n = 1 << 5;  // Set maximum limit
  }

  // Set the tickets count
  myproc()->tickets = n;
  //curproc->stride = TICKETS_TOTAL / curproc->tickets;
  return 0;
}

//init getinfo
int sys_getpinfo(void) {
    struct pstat ps;  // Create a local pstat structure

    // Get the pointer to the pstat structure from user space
    if (argptr(0, (void*)&ps, sizeof(ps)) < 0)
        return -1;  // Return error if argptr fails

    // Call the actual implementation in proc.c
    return getpinfo(&ps);  // Change this line to use the correct function
}


