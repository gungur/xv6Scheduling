
_workload:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
void long_running_task(long duration);
void measure(int counter, int start_time, int fd);
void itoa(int n, char* s);
void write_csv_line(int fd, int current_time, int pid, int tickets, int pass, int stride, int runtime);

int main() {
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 4c             	sub    $0x4c,%esp
  int i;
  int pid;
  printf(1, "Attempting to open file: %s\n", CSVFILE);
  14:	68 24 0d 00 00       	push   $0xd24
  19:	68 3d 0d 00 00       	push   $0xd3d
  1e:	6a 01                	push   $0x1
  20:	e8 ab 09 00 00       	call   9d0 <printf>
  int fd = open(CSVFILE, O_CREATE | O_WRONLY);
  25:	58                   	pop    %eax
  26:	5a                   	pop    %edx
  27:	68 01 02 00 00       	push   $0x201
  2c:	68 24 0d 00 00       	push   $0xd24
  31:	e8 6d 08 00 00       	call   8a3 <open>
  if (fd < 0) {
  36:	83 c4 10             	add    $0x10,%esp
  39:	85 c0                	test   %eax,%eax
  3b:	0f 88 2c 01 00 00    	js     16d <main+0x16d>
    printf(1, "Failed to open file for writing\n");
    exit();
  }
  write(fd, CSVHEADER, strlen(CSVHEADER));
  41:	83 ec 0c             	sub    $0xc,%esp
  44:	89 c3                	mov    %eax,%ebx
  46:	8d 75 cc             	lea    -0x34(%ebp),%esi
  49:	68 e8 0d 00 00       	push   $0xde8
  4e:	e8 4d 06 00 00       	call   6a0 <strlen>
  53:	83 c4 0c             	add    $0xc,%esp
  56:	50                   	push   %eax
  57:	68 e8 0d 00 00       	push   $0xde8
  5c:	53                   	push   %ebx
  5d:	e8 21 08 00 00       	call   883 <write>

  int ticket_values[TOTAL_PROCESSES];
  // Assign tickets for the initial processes
  ticket_values[0] = 1;
  62:	c7 45 a8 01 00 00 00 	movl   $0x1,-0x58(%ebp)
  for (i = 1; i < INITIAL_PROCESSES; i++) {
  69:	8d 4d a8             	lea    -0x58(%ebp),%ecx
  6c:	83 c4 10             	add    $0x10,%esp
  ticket_values[0] = 1;
  6f:	89 c8                	mov    %ecx,%eax
  71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ticket_values[i] = ticket_values[i - 1] * 2; // Tickets: 2, 4, 8, 16, 32, 32, 32, 32, 32
  78:	8b 38                	mov    (%eax),%edi
  for (i = 1; i < INITIAL_PROCESSES; i++) {
  7a:	83 c0 04             	add    $0x4,%eax
    ticket_values[i] = ticket_values[i - 1] * 2; // Tickets: 2, 4, 8, 16, 32, 32, 32, 32, 32
  7d:	8d 14 3f             	lea    (%edi,%edi,1),%edx
  80:	89 10                	mov    %edx,(%eax)
  for (i = 1; i < INITIAL_PROCESSES; i++) {
  82:	39 c6                	cmp    %eax,%esi
  84:	75 f2                	jne    78 <main+0x78>
  }

  // Assign different tickets for the additional processes
  ticket_values[INITIAL_PROCESSES] = 128;
  86:	c7 45 d0 80 00 00 00 	movl   $0x80,-0x30(%ebp)
  for (i = INITIAL_PROCESSES + 1; i < TOTAL_PROCESSES; i++) {
  8d:	8d 51 14             	lea    0x14(%ecx),%edx
    ticket_values[i] = ticket_values[i - 1] / 4; // Tickets: 32, 8, 2, 0, 0, 0
  90:	8b 71 28             	mov    0x28(%ecx),%esi
  93:	85 f6                	test   %esi,%esi
  95:	8d 46 03             	lea    0x3(%esi),%eax
  98:	0f 49 c6             	cmovns %esi,%eax
  for (i = INITIAL_PROCESSES + 1; i < TOTAL_PROCESSES; i++) {
  9b:	83 c1 04             	add    $0x4,%ecx
    ticket_values[i] = ticket_values[i - 1] / 4; // Tickets: 32, 8, 2, 0, 0, 0
  9e:	c1 f8 02             	sar    $0x2,%eax
  a1:	89 41 28             	mov    %eax,0x28(%ecx)
  for (i = INITIAL_PROCESSES + 1; i < TOTAL_PROCESSES; i++) {
  a4:	39 d1                	cmp    %edx,%ecx
  a6:	75 e8                	jne    90 <main+0x90>
  }

  printf(1, "Starting initial %d processes.\n", INITIAL_PROCESSES);
  a8:	50                   	push   %eax
  for (i = 0; i < INITIAL_PROCESSES; i++) {
  a9:	31 f6                	xor    %esi,%esi
  printf(1, "Starting initial %d processes.\n", INITIAL_PROCESSES);
  ab:	6a 0a                	push   $0xa
  ad:	68 10 0e 00 00       	push   $0xe10
  b2:	6a 01                	push   $0x1
  b4:	e8 17 09 00 00       	call   9d0 <printf>
  b9:	83 c4 10             	add    $0x10,%esp
  bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pid = fork();
  c0:	e8 96 07 00 00       	call   85b <fork>
    if (pid < 0) {
  c5:	85 c0                	test   %eax,%eax
  c7:	0f 88 b3 00 00 00    	js     180 <main+0x180>
      printf(1, "Fork failed\n");
      exit();
    }
    else if (pid == 0) {
  cd:	0f 84 c0 00 00 00    	je     193 <main+0x193>
  for (i = 0; i < INITIAL_PROCESSES; i++) {
  d3:	83 c6 01             	add    $0x1,%esi
  d6:	83 fe 0a             	cmp    $0xa,%esi
  d9:	75 e5                	jne    c0 <main+0xc0>
      exit();
    }
  }


  int start_time = uptime();
  db:	e8 1b 08 00 00       	call   8fb <uptime>
  // Allow initial processes to run for a while
  sleep(100);
  e0:	83 ec 0c             	sub    $0xc,%esp
  e3:	6a 64                	push   $0x64
  int start_time = uptime();
  e5:	89 c7                	mov    %eax,%edi
  sleep(100);
  e7:	e8 07 08 00 00       	call   8f3 <sleep>

  measure(20, start_time, fd);
  ec:	83 c4 0c             	add    $0xc,%esp
  ef:	53                   	push   %ebx
  f0:	57                   	push   %edi
  f1:	6a 14                	push   $0x14
  f3:	e8 c8 03 00 00       	call   4c0 <measure>

  printf(1, "Adding additional %d processes with different tickets.\n", ADDITIONAL_PROCESSES);
  f8:	83 c4 0c             	add    $0xc,%esp
  fb:	6a 06                	push   $0x6
  fd:	68 30 0e 00 00       	push   $0xe30
 102:	6a 01                	push   $0x1
 104:	e8 c7 08 00 00       	call   9d0 <printf>
 109:	83 c4 10             	add    $0x10,%esp
  for (i = INITIAL_PROCESSES; i < TOTAL_PROCESSES; i++) {
    pid = fork();
 10c:	e8 4a 07 00 00       	call   85b <fork>
    if (pid < 0) {
 111:	85 c0                	test   %eax,%eax
 113:	78 6b                	js     180 <main+0x180>
      printf(1, "Fork failed\n");
      exit();
    }
    else if (pid == 0) {
 115:	74 7c                	je     193 <main+0x193>
  for (i = INITIAL_PROCESSES; i < TOTAL_PROCESSES; i++) {
 117:	83 c6 01             	add    $0x1,%esi
 11a:	83 fe 10             	cmp    $0x10,%esi
 11d:	75 ed                	jne    10c <main+0x10c>
      exit();
    }
  }


  measure(20, start_time, fd);
 11f:	52                   	push   %edx
 120:	53                   	push   %ebx
 121:	57                   	push   %edi
 122:	6a 14                	push   $0x14
 124:	e8 97 03 00 00       	call   4c0 <measure>
  printf(1, "Done measuring.\n");
 129:	59                   	pop    %ecx
 12a:	5e                   	pop    %esi
 12b:	68 67 0d 00 00       	push   $0xd67
 130:	6a 01                	push   $0x1
 132:	e8 99 08 00 00       	call   9d0 <printf>

  if (fd >= 0) {
    close(fd);
 137:	89 1c 24             	mov    %ebx,(%esp)
 13a:	bb 10 00 00 00       	mov    $0x10,%ebx
 13f:	e8 47 07 00 00       	call   88b <close>
 144:	83 c4 10             	add    $0x10,%esp
 147:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 14e:	66 90                	xchg   %ax,%ax
  }

  for (i = 0; i < TOTAL_PROCESSES; i++) {
    wait();
 150:	e8 16 07 00 00       	call   86b <wait>
  for (i = 0; i < TOTAL_PROCESSES; i++) {
 155:	83 eb 01             	sub    $0x1,%ebx
 158:	75 f6                	jne    150 <main+0x150>
  }
  printf(1, "All child processes have completed.\n");
 15a:	50                   	push   %eax
 15b:	50                   	push   %eax
 15c:	68 68 0e 00 00       	push   $0xe68
 161:	6a 01                	push   $0x1
 163:	e8 68 08 00 00       	call   9d0 <printf>
  exit();
 168:	e8 f6 06 00 00       	call   863 <exit>
    printf(1, "Failed to open file for writing\n");
 16d:	50                   	push   %eax
 16e:	50                   	push   %eax
 16f:	68 c4 0d 00 00       	push   $0xdc4
 174:	6a 01                	push   $0x1
 176:	e8 55 08 00 00       	call   9d0 <printf>
    exit();
 17b:	e8 e3 06 00 00       	call   863 <exit>
      printf(1, "Fork failed\n");
 180:	57                   	push   %edi
 181:	57                   	push   %edi
 182:	68 5a 0d 00 00       	push   $0xd5a
 187:	6a 01                	push   $0x1
 189:	e8 42 08 00 00       	call   9d0 <printf>
      exit();
 18e:	e8 d0 06 00 00       	call   863 <exit>
      settickets(ticket_values[i]); // Set tickets for this process
 193:	83 ec 0c             	sub    $0xc,%esp
 196:	ff 74 b5 a8          	push   -0x58(%ebp,%esi,4)
 19a:	e8 64 07 00 00       	call   903 <settickets>
      long_running_task(WORKLOAD_TIME);
 19f:	c7 04 24 00 e1 f5 05 	movl   $0x5f5e100,(%esp)
 1a6:	e8 a5 00 00 00       	call   250 <long_running_task>
      exit();
 1ab:	e8 b3 06 00 00       	call   863 <exit>

000001b0 <itoa.part.0>:

  // Write to file
  write(fd, buffer, offset);
}

void itoa(int n, char* s) {
 1b0:	55                   	push   %ebp
 1b1:	89 c1                	mov    %eax,%ecx
 1b3:	89 e5                	mov    %esp,%ebp
 1b5:	57                   	push   %edi
 1b6:	56                   	push   %esi
 1b7:	89 d6                	mov    %edx,%esi
 1b9:	53                   	push   %ebx
 1ba:	83 ec 04             	sub    $0x4,%esp
  int i = 0;
  int is_negative = 0;
 1bd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if (n == 0) {
    s[i++] = '0';
    s[i] = '\0';
    return;
  }
  if (n < 0) {
 1c4:	85 c0                	test   %eax,%eax
 1c6:	78 78                	js     240 <itoa.part.0+0x90>
void itoa(int n, char* s) {
 1c8:	31 ff                	xor    %edi,%edi
 1ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    is_negative = 1;
    n = -n;
  }
  while (n > 0) {
    s[i++] = (n % 10) + '0';
 1d0:	b8 cd cc cc cc       	mov    $0xcccccccd,%eax
 1d5:	89 fb                	mov    %edi,%ebx
 1d7:	8d 7f 01             	lea    0x1(%edi),%edi
 1da:	f7 e1                	mul    %ecx
 1dc:	c1 ea 03             	shr    $0x3,%edx
 1df:	8d 04 92             	lea    (%edx,%edx,4),%eax
 1e2:	01 c0                	add    %eax,%eax
 1e4:	29 c1                	sub    %eax,%ecx
 1e6:	83 c1 30             	add    $0x30,%ecx
 1e9:	88 4c 3e ff          	mov    %cl,-0x1(%esi,%edi,1)
    n /= 10;
 1ed:	89 d1                	mov    %edx,%ecx
  while (n > 0) {
 1ef:	85 d2                	test   %edx,%edx
 1f1:	75 dd                	jne    1d0 <itoa.part.0+0x20>
  }
  if (is_negative) {
 1f3:	8b 55 f0             	mov    -0x10(%ebp),%edx
    s[i++] = '-';
 1f6:	8d 04 3e             	lea    (%esi,%edi,1),%eax
  if (is_negative) {
 1f9:	85 d2                	test   %edx,%edx
 1fb:	74 33                	je     230 <itoa.part.0+0x80>
    s[i++] = '-';
 1fd:	c6 00 2d             	movb   $0x2d,(%eax)
  }
  s[i] = '\0';
 200:	c6 44 1e 02 00       	movb   $0x0,0x2(%esi,%ebx,1)
    s[i++] = (n % 10) + '0';
 205:	89 fb                	mov    %edi,%ebx
 207:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 20e:	66 90                	xchg   %ax,%ax
  // Reverse the string
  int start = 0;
  int end = i - 1;
  char temp;
  while (start < end) {
    temp = s[start];
 210:	0f b6 14 0e          	movzbl (%esi,%ecx,1),%edx
    s[start] = s[end];
 214:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
 218:	88 04 0e             	mov    %al,(%esi,%ecx,1)
    s[end] = temp;
    start++;
 21b:	83 c1 01             	add    $0x1,%ecx
    s[end] = temp;
 21e:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
    end--;
 221:	83 eb 01             	sub    $0x1,%ebx
  while (start < end) {
 224:	39 d9                	cmp    %ebx,%ecx
 226:	7c e8                	jl     210 <itoa.part.0+0x60>
  }
}
 228:	83 c4 04             	add    $0x4,%esp
 22b:	5b                   	pop    %ebx
 22c:	5e                   	pop    %esi
 22d:	5f                   	pop    %edi
 22e:	5d                   	pop    %ebp
 22f:	c3                   	ret    
  s[i] = '\0';
 230:	c6 00 00             	movb   $0x0,(%eax)
  while (start < end) {
 233:	85 db                	test   %ebx,%ebx
 235:	75 d9                	jne    210 <itoa.part.0+0x60>
}
 237:	83 c4 04             	add    $0x4,%esp
 23a:	5b                   	pop    %ebx
 23b:	5e                   	pop    %esi
 23c:	5f                   	pop    %edi
 23d:	5d                   	pop    %ebp
 23e:	c3                   	ret    
 23f:	90                   	nop
    is_negative = 1;
 240:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    n = -n;
 247:	f7 d9                	neg    %ecx
 249:	e9 7a ff ff ff       	jmp    1c8 <itoa.part.0+0x18>
 24e:	66 90                	xchg   %ax,%ax

00000250 <long_running_task>:
void long_running_task(long duration) {
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	83 ec 10             	sub    $0x10,%esp
  for (i = 0; i < duration; i++) {
 256:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
void long_running_task(long duration) {
 25d:	8b 55 08             	mov    0x8(%ebp),%edx
  for (i = 0; i < duration; i++) {
 260:	8b 45 f8             	mov    -0x8(%ebp),%eax
 263:	39 c2                	cmp    %eax,%edx
 265:	7e 39                	jle    2a0 <long_running_task+0x50>
 267:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 26e:	66 90                	xchg   %ax,%ax
    for (j = 0; j < duration; j++) {
 270:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 277:	8b 45 fc             	mov    -0x4(%ebp),%eax
 27a:	39 c2                	cmp    %eax,%edx
 27c:	7e 12                	jle    290 <long_running_task+0x40>
 27e:	66 90                	xchg   %ax,%ax
 280:	8b 45 fc             	mov    -0x4(%ebp),%eax
 283:	83 c0 01             	add    $0x1,%eax
 286:	89 45 fc             	mov    %eax,-0x4(%ebp)
 289:	8b 45 fc             	mov    -0x4(%ebp),%eax
 28c:	39 d0                	cmp    %edx,%eax
 28e:	7c f0                	jl     280 <long_running_task+0x30>
  for (i = 0; i < duration; i++) {
 290:	8b 45 f8             	mov    -0x8(%ebp),%eax
 293:	83 c0 01             	add    $0x1,%eax
 296:	89 45 f8             	mov    %eax,-0x8(%ebp)
 299:	8b 45 f8             	mov    -0x8(%ebp),%eax
 29c:	39 d0                	cmp    %edx,%eax
 29e:	7c d0                	jl     270 <long_running_task+0x20>
}
 2a0:	c9                   	leave  
 2a1:	c3                   	ret    
 2a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002b0 <write_csv_line>:
void write_csv_line(int fd, int current_time, int pid, int tickets, int pass, int stride, int runtime) {
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	57                   	push   %edi
 2b4:	56                   	push   %esi
 2b5:	53                   	push   %ebx
 2b6:	81 ec 1c 01 00 00    	sub    $0x11c,%esp
 2bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  if (n == 0) {
 2bf:	85 c0                	test   %eax,%eax
 2c1:	0f 84 71 01 00 00    	je     438 <write_csv_line+0x188>
 2c7:	8d 9d dc fe ff ff    	lea    -0x124(%ebp),%ebx
 2cd:	89 da                	mov    %ebx,%edx
 2cf:	e8 dc fe ff ff       	call   1b0 <itoa.part.0>
  strcpy(buffer + offset, temp_str);
 2d4:	83 ec 08             	sub    $0x8,%esp
 2d7:	8d b5 e8 fe ff ff    	lea    -0x118(%ebp),%esi
 2dd:	53                   	push   %ebx
 2de:	56                   	push   %esi
 2df:	e8 2c 03 00 00       	call   610 <strcpy>
  offset += strlen(temp_str);
 2e4:	89 1c 24             	mov    %ebx,(%esp)
 2e7:	e8 b4 03 00 00       	call   6a0 <strlen>
  if (n == 0) {
 2ec:	8b 4d 10             	mov    0x10(%ebp),%ecx
 2ef:	83 c4 10             	add    $0x10,%esp
  buffer[offset++] = ',';
 2f2:	c6 84 05 e8 fe ff ff 	movb   $0x2c,-0x118(%ebp,%eax,1)
 2f9:	2c 
 2fa:	8d 78 01             	lea    0x1(%eax),%edi
  if (n == 0) {
 2fd:	85 c9                	test   %ecx,%ecx
 2ff:	0f 84 a3 01 00 00    	je     4a8 <write_csv_line+0x1f8>
 305:	8b 45 10             	mov    0x10(%ebp),%eax
 308:	89 da                	mov    %ebx,%edx
 30a:	e8 a1 fe ff ff       	call   1b0 <itoa.part.0>
  strcpy(buffer + offset, temp_str);
 30f:	83 ec 08             	sub    $0x8,%esp
 312:	8d 04 3e             	lea    (%esi,%edi,1),%eax
 315:	53                   	push   %ebx
 316:	50                   	push   %eax
 317:	e8 f4 02 00 00       	call   610 <strcpy>
  offset += strlen(temp_str);
 31c:	89 1c 24             	mov    %ebx,(%esp)
 31f:	e8 7c 03 00 00       	call   6a0 <strlen>
  if (n == 0) {
 324:	83 c4 10             	add    $0x10,%esp
  offset += strlen(temp_str);
 327:	01 f8                	add    %edi,%eax
  buffer[offset++] = ',';
 329:	c6 84 05 e8 fe ff ff 	movb   $0x2c,-0x118(%ebp,%eax,1)
 330:	2c 
 331:	8d 78 01             	lea    0x1(%eax),%edi
  if (n == 0) {
 334:	8b 45 14             	mov    0x14(%ebp),%eax
 337:	85 c0                	test   %eax,%eax
 339:	0f 84 51 01 00 00    	je     490 <write_csv_line+0x1e0>
 33f:	8b 45 14             	mov    0x14(%ebp),%eax
 342:	89 da                	mov    %ebx,%edx
 344:	e8 67 fe ff ff       	call   1b0 <itoa.part.0>
  strcpy(buffer + offset, temp_str);
 349:	83 ec 08             	sub    $0x8,%esp
 34c:	8d 04 3e             	lea    (%esi,%edi,1),%eax
 34f:	53                   	push   %ebx
 350:	50                   	push   %eax
 351:	e8 ba 02 00 00       	call   610 <strcpy>
  offset += strlen(temp_str);
 356:	89 1c 24             	mov    %ebx,(%esp)
 359:	e8 42 03 00 00       	call   6a0 <strlen>
  if (n == 0) {
 35e:	83 c4 10             	add    $0x10,%esp
  offset += strlen(temp_str);
 361:	01 f8                	add    %edi,%eax
  buffer[offset++] = ',';
 363:	c6 84 05 e8 fe ff ff 	movb   $0x2c,-0x118(%ebp,%eax,1)
 36a:	2c 
 36b:	8d 78 01             	lea    0x1(%eax),%edi
  if (n == 0) {
 36e:	8b 45 18             	mov    0x18(%ebp),%eax
 371:	85 c0                	test   %eax,%eax
 373:	0f 84 ff 00 00 00    	je     478 <write_csv_line+0x1c8>
 379:	8b 45 18             	mov    0x18(%ebp),%eax
 37c:	89 da                	mov    %ebx,%edx
 37e:	e8 2d fe ff ff       	call   1b0 <itoa.part.0>
  strcpy(buffer + offset, temp_str);
 383:	83 ec 08             	sub    $0x8,%esp
 386:	8d 04 3e             	lea    (%esi,%edi,1),%eax
 389:	53                   	push   %ebx
 38a:	50                   	push   %eax
 38b:	e8 80 02 00 00       	call   610 <strcpy>
  offset += strlen(temp_str);
 390:	89 1c 24             	mov    %ebx,(%esp)
 393:	e8 08 03 00 00       	call   6a0 <strlen>
  if (n == 0) {
 398:	83 c4 10             	add    $0x10,%esp
  offset += strlen(temp_str);
 39b:	01 f8                	add    %edi,%eax
  buffer[offset++] = ',';
 39d:	c6 84 05 e8 fe ff ff 	movb   $0x2c,-0x118(%ebp,%eax,1)
 3a4:	2c 
 3a5:	8d 78 01             	lea    0x1(%eax),%edi
  if (n == 0) {
 3a8:	8b 45 1c             	mov    0x1c(%ebp),%eax
 3ab:	85 c0                	test   %eax,%eax
 3ad:	0f 84 ad 00 00 00    	je     460 <write_csv_line+0x1b0>
 3b3:	8b 45 1c             	mov    0x1c(%ebp),%eax
 3b6:	89 da                	mov    %ebx,%edx
 3b8:	e8 f3 fd ff ff       	call   1b0 <itoa.part.0>
  strcpy(buffer + offset, temp_str);
 3bd:	83 ec 08             	sub    $0x8,%esp
 3c0:	8d 04 3e             	lea    (%esi,%edi,1),%eax
 3c3:	53                   	push   %ebx
 3c4:	50                   	push   %eax
 3c5:	e8 46 02 00 00       	call   610 <strcpy>
  offset += strlen(temp_str);
 3ca:	89 1c 24             	mov    %ebx,(%esp)
 3cd:	e8 ce 02 00 00       	call   6a0 <strlen>
  if (n == 0) {
 3d2:	8b 55 20             	mov    0x20(%ebp),%edx
 3d5:	83 c4 10             	add    $0x10,%esp
  offset += strlen(temp_str);
 3d8:	01 f8                	add    %edi,%eax
  buffer[offset++] = ',';
 3da:	c6 84 05 e8 fe ff ff 	movb   $0x2c,-0x118(%ebp,%eax,1)
 3e1:	2c 
 3e2:	8d 78 01             	lea    0x1(%eax),%edi
  if (n == 0) {
 3e5:	85 d2                	test   %edx,%edx
 3e7:	74 67                	je     450 <write_csv_line+0x1a0>
 3e9:	8b 45 20             	mov    0x20(%ebp),%eax
 3ec:	89 da                	mov    %ebx,%edx
 3ee:	e8 bd fd ff ff       	call   1b0 <itoa.part.0>
  strcpy(buffer + offset, temp_str);
 3f3:	83 ec 08             	sub    $0x8,%esp
 3f6:	8d 04 3e             	lea    (%esi,%edi,1),%eax
 3f9:	53                   	push   %ebx
 3fa:	50                   	push   %eax
 3fb:	e8 10 02 00 00       	call   610 <strcpy>
  offset += strlen(temp_str);
 400:	89 1c 24             	mov    %ebx,(%esp)
 403:	e8 98 02 00 00       	call   6a0 <strlen>
  write(fd, buffer, offset);
 408:	83 c4 0c             	add    $0xc,%esp
  offset += strlen(temp_str);
 40b:	01 c7                	add    %eax,%edi
  buffer[offset++] = '\n';
 40d:	8d 47 01             	lea    0x1(%edi),%eax
 410:	c6 84 3d e8 fe ff ff 	movb   $0xa,-0x118(%ebp,%edi,1)
 417:	0a 
  write(fd, buffer, offset);
 418:	50                   	push   %eax
 419:	56                   	push   %esi
 41a:	ff 75 08             	push   0x8(%ebp)
  buffer[offset] = '\0';
 41d:	c6 84 3d e9 fe ff ff 	movb   $0x0,-0x117(%ebp,%edi,1)
 424:	00 
  write(fd, buffer, offset);
 425:	e8 59 04 00 00       	call   883 <write>
}
 42a:	83 c4 10             	add    $0x10,%esp
 42d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 430:	5b                   	pop    %ebx
 431:	5e                   	pop    %esi
 432:	5f                   	pop    %edi
 433:	5d                   	pop    %ebp
 434:	c3                   	ret    
 435:	8d 76 00             	lea    0x0(%esi),%esi
    s[i++] = '0';
 438:	bb 30 00 00 00       	mov    $0x30,%ebx
 43d:	66 89 9d dc fe ff ff 	mov    %bx,-0x124(%ebp)
    return;
 444:	8d 9d dc fe ff ff    	lea    -0x124(%ebp),%ebx
 44a:	e9 85 fe ff ff       	jmp    2d4 <write_csv_line+0x24>
 44f:	90                   	nop
    s[i++] = '0';
 450:	b8 30 00 00 00       	mov    $0x30,%eax
 455:	66 89 85 dc fe ff ff 	mov    %ax,-0x124(%ebp)
    return;
 45c:	eb 95                	jmp    3f3 <write_csv_line+0x143>
 45e:	66 90                	xchg   %ax,%ax
    s[i++] = '0';
 460:	b9 30 00 00 00       	mov    $0x30,%ecx
 465:	66 89 8d dc fe ff ff 	mov    %cx,-0x124(%ebp)
    return;
 46c:	e9 4c ff ff ff       	jmp    3bd <write_csv_line+0x10d>
 471:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    s[i++] = '0';
 478:	b8 30 00 00 00       	mov    $0x30,%eax
 47d:	66 89 85 dc fe ff ff 	mov    %ax,-0x124(%ebp)
    return;
 484:	e9 fa fe ff ff       	jmp    383 <write_csv_line+0xd3>
 489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    s[i++] = '0';
 490:	b8 30 00 00 00       	mov    $0x30,%eax
 495:	66 89 85 dc fe ff ff 	mov    %ax,-0x124(%ebp)
    return;
 49c:	e9 a8 fe ff ff       	jmp    349 <write_csv_line+0x99>
 4a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    s[i++] = '0';
 4a8:	ba 30 00 00 00       	mov    $0x30,%edx
 4ad:	66 89 95 dc fe ff ff 	mov    %dx,-0x124(%ebp)
    return;
 4b4:	e9 56 fe ff ff       	jmp    30f <write_csv_line+0x5f>
 4b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000004c0 <measure>:
void measure(int counter, int start_time, int fd) {
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	57                   	push   %edi
 4c4:	56                   	push   %esi
 4c5:	53                   	push   %ebx
 4c6:	81 ec 0c 07 00 00    	sub    $0x70c,%esp
  while (counter) {
 4cc:	8b 5d 08             	mov    0x8(%ebp),%ebx
 4cf:	85 db                	test   %ebx,%ebx
 4d1:	0f 84 de 00 00 00    	je     5b5 <measure+0xf5>
 4d7:	8d bd e8 f9 ff ff    	lea    -0x618(%ebp),%edi
 4dd:	8d 76 00             	lea    0x0(%esi),%esi
    if (getpinfo(&ps) != 0) {
 4e0:	83 ec 0c             	sub    $0xc,%esp
 4e3:	8d 85 e8 f8 ff ff    	lea    -0x718(%ebp),%eax
 4e9:	50                   	push   %eax
 4ea:	e8 1c 04 00 00       	call   90b <getpinfo>
 4ef:	83 c4 10             	add    $0x10,%esp
 4f2:	85 c0                	test   %eax,%eax
 4f4:	0f 85 c3 00 00 00    	jne    5bd <measure+0xfd>
    int curr_time = uptime() - start_time;
 4fa:	e8 fc 03 00 00       	call   8fb <uptime>
    printf(1, "\nProcess statistics at time %d ticks:\n", curr_time);
 4ff:	83 ec 04             	sub    $0x4,%esp
    int curr_time = uptime() - start_time;
 502:	2b 45 0c             	sub    0xc(%ebp),%eax
 505:	8d b5 e8 f8 ff ff    	lea    -0x718(%ebp),%esi
    printf(1, "\nProcess statistics at time %d ticks:\n", curr_time);
 50b:	50                   	push   %eax
    int curr_time = uptime() - start_time;
 50c:	89 c3                	mov    %eax,%ebx
    printf(1, "\nProcess statistics at time %d ticks:\n", curr_time);
 50e:	68 78 0d 00 00       	push   $0xd78
 513:	6a 01                	push   $0x1
 515:	e8 b6 04 00 00       	call   9d0 <printf>
    printf(1, "PID\tTickets\tPass\tStride\tRuntime\n");
 51a:	5a                   	pop    %edx
 51b:	59                   	pop    %ecx
 51c:	68 a0 0d 00 00       	push   $0xda0
 521:	6a 01                	push   $0x1
 523:	e8 a8 04 00 00       	call   9d0 <printf>
    for (int i = 0; i < NPROC; i++) {
 528:	83 c4 10             	add    $0x10,%esp
 52b:	eb 0a                	jmp    537 <measure+0x77>
 52d:	8d 76 00             	lea    0x0(%esi),%esi
 530:	83 c6 04             	add    $0x4,%esi
 533:	39 fe                	cmp    %edi,%esi
 535:	74 67                	je     59e <measure+0xde>
      if (ps.inuse[i]) {
 537:	8b 06                	mov    (%esi),%eax
 539:	85 c0                	test   %eax,%eax
 53b:	74 f3                	je     530 <measure+0x70>
        printf(1, "%d\t%d\t%d\t%d\t%d\n",
 53d:	83 ec 04             	sub    $0x4,%esp
 540:	ff b6 00 06 00 00    	push   0x600(%esi)
    for (int i = 0; i < NPROC; i++) {
 546:	83 c6 04             	add    $0x4,%esi
        printf(1, "%d\t%d\t%d\t%d\t%d\n",
 549:	ff b6 fc 04 00 00    	push   0x4fc(%esi)
 54f:	ff b6 fc 02 00 00    	push   0x2fc(%esi)
 555:	ff b6 fc 00 00 00    	push   0xfc(%esi)
 55b:	ff b6 fc 01 00 00    	push   0x1fc(%esi)
 561:	68 14 0d 00 00       	push   $0xd14
 566:	6a 01                	push   $0x1
 568:	e8 63 04 00 00       	call   9d0 <printf>
        write_csv_line(fd,
 56d:	83 c4 1c             	add    $0x1c,%esp
 570:	ff b6 fc 05 00 00    	push   0x5fc(%esi)
 576:	ff b6 fc 04 00 00    	push   0x4fc(%esi)
 57c:	ff b6 fc 02 00 00    	push   0x2fc(%esi)
 582:	ff b6 fc 00 00 00    	push   0xfc(%esi)
 588:	ff b6 fc 01 00 00    	push   0x1fc(%esi)
 58e:	53                   	push   %ebx
 58f:	ff 75 10             	push   0x10(%ebp)
 592:	e8 19 fd ff ff       	call   2b0 <write_csv_line>
 597:	83 c4 20             	add    $0x20,%esp
    for (int i = 0; i < NPROC; i++) {
 59a:	39 fe                	cmp    %edi,%esi
 59c:	75 99                	jne    537 <measure+0x77>
    sleep(50); // Collect data every 50 ticks
 59e:	83 ec 0c             	sub    $0xc,%esp
 5a1:	6a 32                	push   $0x32
 5a3:	e8 4b 03 00 00       	call   8f3 <sleep>
  while (counter) {
 5a8:	83 c4 10             	add    $0x10,%esp
 5ab:	83 6d 08 01          	subl   $0x1,0x8(%ebp)
 5af:	0f 85 2b ff ff ff    	jne    4e0 <measure+0x20>
}
 5b5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5b8:	5b                   	pop    %ebx
 5b9:	5e                   	pop    %esi
 5ba:	5f                   	pop    %edi
 5bb:	5d                   	pop    %ebp
 5bc:	c3                   	ret    
      printf(1, "Failed to get process info\n");
 5bd:	83 ec 08             	sub    $0x8,%esp
 5c0:	68 f8 0c 00 00       	push   $0xcf8
 5c5:	6a 01                	push   $0x1
 5c7:	e8 04 04 00 00       	call   9d0 <printf>
      exit();
 5cc:	e8 92 02 00 00       	call   863 <exit>
 5d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5df:	90                   	nop

000005e0 <itoa>:
void itoa(int n, char* s) {
 5e0:	55                   	push   %ebp
 5e1:	89 e5                	mov    %esp,%ebp
 5e3:	8b 45 08             	mov    0x8(%ebp),%eax
 5e6:	8b 55 0c             	mov    0xc(%ebp),%edx
  if (n == 0) {
 5e9:	85 c0                	test   %eax,%eax
 5eb:	74 0b                	je     5f8 <itoa+0x18>
}
 5ed:	5d                   	pop    %ebp
 5ee:	e9 bd fb ff ff       	jmp    1b0 <itoa.part.0>
 5f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5f7:	90                   	nop
    s[i++] = '0';
 5f8:	b8 30 00 00 00       	mov    $0x30,%eax
 5fd:	66 89 02             	mov    %ax,(%edx)
}
 600:	5d                   	pop    %ebp
 601:	c3                   	ret    
 602:	66 90                	xchg   %ax,%ax
 604:	66 90                	xchg   %ax,%ax
 606:	66 90                	xchg   %ax,%ax
 608:	66 90                	xchg   %ax,%ax
 60a:	66 90                	xchg   %ax,%ax
 60c:	66 90                	xchg   %ax,%ax
 60e:	66 90                	xchg   %ax,%ax

00000610 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 610:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 611:	31 c0                	xor    %eax,%eax
{
 613:	89 e5                	mov    %esp,%ebp
 615:	53                   	push   %ebx
 616:	8b 4d 08             	mov    0x8(%ebp),%ecx
 619:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 61c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 620:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 624:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 627:	83 c0 01             	add    $0x1,%eax
 62a:	84 d2                	test   %dl,%dl
 62c:	75 f2                	jne    620 <strcpy+0x10>
    ;
  return os;
}
 62e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 631:	89 c8                	mov    %ecx,%eax
 633:	c9                   	leave  
 634:	c3                   	ret    
 635:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 63c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000640 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 640:	55                   	push   %ebp
 641:	89 e5                	mov    %esp,%ebp
 643:	53                   	push   %ebx
 644:	8b 55 08             	mov    0x8(%ebp),%edx
 647:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 64a:	0f b6 02             	movzbl (%edx),%eax
 64d:	84 c0                	test   %al,%al
 64f:	75 17                	jne    668 <strcmp+0x28>
 651:	eb 3a                	jmp    68d <strcmp+0x4d>
 653:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 657:	90                   	nop
 658:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 65c:	83 c2 01             	add    $0x1,%edx
 65f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 662:	84 c0                	test   %al,%al
 664:	74 1a                	je     680 <strcmp+0x40>
    p++, q++;
 666:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
 668:	0f b6 19             	movzbl (%ecx),%ebx
 66b:	38 c3                	cmp    %al,%bl
 66d:	74 e9                	je     658 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 66f:	29 d8                	sub    %ebx,%eax
}
 671:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 674:	c9                   	leave  
 675:	c3                   	ret    
 676:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 67d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 680:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 684:	31 c0                	xor    %eax,%eax
 686:	29 d8                	sub    %ebx,%eax
}
 688:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 68b:	c9                   	leave  
 68c:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
 68d:	0f b6 19             	movzbl (%ecx),%ebx
 690:	31 c0                	xor    %eax,%eax
 692:	eb db                	jmp    66f <strcmp+0x2f>
 694:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 69b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 69f:	90                   	nop

000006a0 <strlen>:

uint
strlen(const char *s)
{
 6a0:	55                   	push   %ebp
 6a1:	89 e5                	mov    %esp,%ebp
 6a3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 6a6:	80 3a 00             	cmpb   $0x0,(%edx)
 6a9:	74 15                	je     6c0 <strlen+0x20>
 6ab:	31 c0                	xor    %eax,%eax
 6ad:	8d 76 00             	lea    0x0(%esi),%esi
 6b0:	83 c0 01             	add    $0x1,%eax
 6b3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 6b7:	89 c1                	mov    %eax,%ecx
 6b9:	75 f5                	jne    6b0 <strlen+0x10>
    ;
  return n;
}
 6bb:	89 c8                	mov    %ecx,%eax
 6bd:	5d                   	pop    %ebp
 6be:	c3                   	ret    
 6bf:	90                   	nop
  for(n = 0; s[n]; n++)
 6c0:	31 c9                	xor    %ecx,%ecx
}
 6c2:	5d                   	pop    %ebp
 6c3:	89 c8                	mov    %ecx,%eax
 6c5:	c3                   	ret    
 6c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6cd:	8d 76 00             	lea    0x0(%esi),%esi

000006d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 6d0:	55                   	push   %ebp
 6d1:	89 e5                	mov    %esp,%ebp
 6d3:	57                   	push   %edi
 6d4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 6d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 6da:	8b 45 0c             	mov    0xc(%ebp),%eax
 6dd:	89 d7                	mov    %edx,%edi
 6df:	fc                   	cld    
 6e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 6e2:	8b 7d fc             	mov    -0x4(%ebp),%edi
 6e5:	89 d0                	mov    %edx,%eax
 6e7:	c9                   	leave  
 6e8:	c3                   	ret    
 6e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000006f0 <strchr>:

char*
strchr(const char *s, char c)
{
 6f0:	55                   	push   %ebp
 6f1:	89 e5                	mov    %esp,%ebp
 6f3:	8b 45 08             	mov    0x8(%ebp),%eax
 6f6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 6fa:	0f b6 10             	movzbl (%eax),%edx
 6fd:	84 d2                	test   %dl,%dl
 6ff:	75 12                	jne    713 <strchr+0x23>
 701:	eb 1d                	jmp    720 <strchr+0x30>
 703:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 707:	90                   	nop
 708:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 70c:	83 c0 01             	add    $0x1,%eax
 70f:	84 d2                	test   %dl,%dl
 711:	74 0d                	je     720 <strchr+0x30>
    if(*s == c)
 713:	38 d1                	cmp    %dl,%cl
 715:	75 f1                	jne    708 <strchr+0x18>
      return (char*)s;
  return 0;
}
 717:	5d                   	pop    %ebp
 718:	c3                   	ret    
 719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 720:	31 c0                	xor    %eax,%eax
}
 722:	5d                   	pop    %ebp
 723:	c3                   	ret    
 724:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 72b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 72f:	90                   	nop

00000730 <gets>:

char*
gets(char *buf, int max)
{
 730:	55                   	push   %ebp
 731:	89 e5                	mov    %esp,%ebp
 733:	57                   	push   %edi
 734:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 735:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 738:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 739:	31 db                	xor    %ebx,%ebx
{
 73b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 73e:	eb 27                	jmp    767 <gets+0x37>
    cc = read(0, &c, 1);
 740:	83 ec 04             	sub    $0x4,%esp
 743:	6a 01                	push   $0x1
 745:	57                   	push   %edi
 746:	6a 00                	push   $0x0
 748:	e8 2e 01 00 00       	call   87b <read>
    if(cc < 1)
 74d:	83 c4 10             	add    $0x10,%esp
 750:	85 c0                	test   %eax,%eax
 752:	7e 1d                	jle    771 <gets+0x41>
      break;
    buf[i++] = c;
 754:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 758:	8b 55 08             	mov    0x8(%ebp),%edx
 75b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 75f:	3c 0a                	cmp    $0xa,%al
 761:	74 1d                	je     780 <gets+0x50>
 763:	3c 0d                	cmp    $0xd,%al
 765:	74 19                	je     780 <gets+0x50>
  for(i=0; i+1 < max; ){
 767:	89 de                	mov    %ebx,%esi
 769:	83 c3 01             	add    $0x1,%ebx
 76c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 76f:	7c cf                	jl     740 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 771:	8b 45 08             	mov    0x8(%ebp),%eax
 774:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 778:	8d 65 f4             	lea    -0xc(%ebp),%esp
 77b:	5b                   	pop    %ebx
 77c:	5e                   	pop    %esi
 77d:	5f                   	pop    %edi
 77e:	5d                   	pop    %ebp
 77f:	c3                   	ret    
  buf[i] = '\0';
 780:	8b 45 08             	mov    0x8(%ebp),%eax
 783:	89 de                	mov    %ebx,%esi
 785:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 789:	8d 65 f4             	lea    -0xc(%ebp),%esp
 78c:	5b                   	pop    %ebx
 78d:	5e                   	pop    %esi
 78e:	5f                   	pop    %edi
 78f:	5d                   	pop    %ebp
 790:	c3                   	ret    
 791:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 798:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 79f:	90                   	nop

000007a0 <stat>:

int
stat(const char *n, struct stat *st)
{
 7a0:	55                   	push   %ebp
 7a1:	89 e5                	mov    %esp,%ebp
 7a3:	56                   	push   %esi
 7a4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 7a5:	83 ec 08             	sub    $0x8,%esp
 7a8:	6a 00                	push   $0x0
 7aa:	ff 75 08             	push   0x8(%ebp)
 7ad:	e8 f1 00 00 00       	call   8a3 <open>
  if(fd < 0)
 7b2:	83 c4 10             	add    $0x10,%esp
 7b5:	85 c0                	test   %eax,%eax
 7b7:	78 27                	js     7e0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 7b9:	83 ec 08             	sub    $0x8,%esp
 7bc:	ff 75 0c             	push   0xc(%ebp)
 7bf:	89 c3                	mov    %eax,%ebx
 7c1:	50                   	push   %eax
 7c2:	e8 f4 00 00 00       	call   8bb <fstat>
  close(fd);
 7c7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 7ca:	89 c6                	mov    %eax,%esi
  close(fd);
 7cc:	e8 ba 00 00 00       	call   88b <close>
  return r;
 7d1:	83 c4 10             	add    $0x10,%esp
}
 7d4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 7d7:	89 f0                	mov    %esi,%eax
 7d9:	5b                   	pop    %ebx
 7da:	5e                   	pop    %esi
 7db:	5d                   	pop    %ebp
 7dc:	c3                   	ret    
 7dd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 7e0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 7e5:	eb ed                	jmp    7d4 <stat+0x34>
 7e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7ee:	66 90                	xchg   %ax,%ax

000007f0 <atoi>:

int
atoi(const char *s)
{
 7f0:	55                   	push   %ebp
 7f1:	89 e5                	mov    %esp,%ebp
 7f3:	53                   	push   %ebx
 7f4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 7f7:	0f be 02             	movsbl (%edx),%eax
 7fa:	8d 48 d0             	lea    -0x30(%eax),%ecx
 7fd:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 800:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 805:	77 1e                	ja     825 <atoi+0x35>
 807:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 80e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 810:	83 c2 01             	add    $0x1,%edx
 813:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 816:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 81a:	0f be 02             	movsbl (%edx),%eax
 81d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 820:	80 fb 09             	cmp    $0x9,%bl
 823:	76 eb                	jbe    810 <atoi+0x20>
  return n;
}
 825:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 828:	89 c8                	mov    %ecx,%eax
 82a:	c9                   	leave  
 82b:	c3                   	ret    
 82c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000830 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 830:	55                   	push   %ebp
 831:	89 e5                	mov    %esp,%ebp
 833:	57                   	push   %edi
 834:	8b 45 10             	mov    0x10(%ebp),%eax
 837:	8b 55 08             	mov    0x8(%ebp),%edx
 83a:	56                   	push   %esi
 83b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 83e:	85 c0                	test   %eax,%eax
 840:	7e 13                	jle    855 <memmove+0x25>
 842:	01 d0                	add    %edx,%eax
  dst = vdst;
 844:	89 d7                	mov    %edx,%edi
 846:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 84d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 850:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 851:	39 f8                	cmp    %edi,%eax
 853:	75 fb                	jne    850 <memmove+0x20>
  return vdst;
}
 855:	5e                   	pop    %esi
 856:	89 d0                	mov    %edx,%eax
 858:	5f                   	pop    %edi
 859:	5d                   	pop    %ebp
 85a:	c3                   	ret    

0000085b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 85b:	b8 01 00 00 00       	mov    $0x1,%eax
 860:	cd 40                	int    $0x40
 862:	c3                   	ret    

00000863 <exit>:
SYSCALL(exit)
 863:	b8 02 00 00 00       	mov    $0x2,%eax
 868:	cd 40                	int    $0x40
 86a:	c3                   	ret    

0000086b <wait>:
SYSCALL(wait)
 86b:	b8 03 00 00 00       	mov    $0x3,%eax
 870:	cd 40                	int    $0x40
 872:	c3                   	ret    

00000873 <pipe>:
SYSCALL(pipe)
 873:	b8 04 00 00 00       	mov    $0x4,%eax
 878:	cd 40                	int    $0x40
 87a:	c3                   	ret    

0000087b <read>:
SYSCALL(read)
 87b:	b8 05 00 00 00       	mov    $0x5,%eax
 880:	cd 40                	int    $0x40
 882:	c3                   	ret    

00000883 <write>:
SYSCALL(write)
 883:	b8 10 00 00 00       	mov    $0x10,%eax
 888:	cd 40                	int    $0x40
 88a:	c3                   	ret    

0000088b <close>:
SYSCALL(close)
 88b:	b8 15 00 00 00       	mov    $0x15,%eax
 890:	cd 40                	int    $0x40
 892:	c3                   	ret    

00000893 <kill>:
SYSCALL(kill)
 893:	b8 06 00 00 00       	mov    $0x6,%eax
 898:	cd 40                	int    $0x40
 89a:	c3                   	ret    

0000089b <exec>:
SYSCALL(exec)
 89b:	b8 07 00 00 00       	mov    $0x7,%eax
 8a0:	cd 40                	int    $0x40
 8a2:	c3                   	ret    

000008a3 <open>:
SYSCALL(open)
 8a3:	b8 0f 00 00 00       	mov    $0xf,%eax
 8a8:	cd 40                	int    $0x40
 8aa:	c3                   	ret    

000008ab <mknod>:
SYSCALL(mknod)
 8ab:	b8 11 00 00 00       	mov    $0x11,%eax
 8b0:	cd 40                	int    $0x40
 8b2:	c3                   	ret    

000008b3 <unlink>:
SYSCALL(unlink)
 8b3:	b8 12 00 00 00       	mov    $0x12,%eax
 8b8:	cd 40                	int    $0x40
 8ba:	c3                   	ret    

000008bb <fstat>:
SYSCALL(fstat)
 8bb:	b8 08 00 00 00       	mov    $0x8,%eax
 8c0:	cd 40                	int    $0x40
 8c2:	c3                   	ret    

000008c3 <link>:
SYSCALL(link)
 8c3:	b8 13 00 00 00       	mov    $0x13,%eax
 8c8:	cd 40                	int    $0x40
 8ca:	c3                   	ret    

000008cb <mkdir>:
SYSCALL(mkdir)
 8cb:	b8 14 00 00 00       	mov    $0x14,%eax
 8d0:	cd 40                	int    $0x40
 8d2:	c3                   	ret    

000008d3 <chdir>:
SYSCALL(chdir)
 8d3:	b8 09 00 00 00       	mov    $0x9,%eax
 8d8:	cd 40                	int    $0x40
 8da:	c3                   	ret    

000008db <dup>:
SYSCALL(dup)
 8db:	b8 0a 00 00 00       	mov    $0xa,%eax
 8e0:	cd 40                	int    $0x40
 8e2:	c3                   	ret    

000008e3 <getpid>:
SYSCALL(getpid)
 8e3:	b8 0b 00 00 00       	mov    $0xb,%eax
 8e8:	cd 40                	int    $0x40
 8ea:	c3                   	ret    

000008eb <sbrk>:
SYSCALL(sbrk)
 8eb:	b8 0c 00 00 00       	mov    $0xc,%eax
 8f0:	cd 40                	int    $0x40
 8f2:	c3                   	ret    

000008f3 <sleep>:
SYSCALL(sleep)
 8f3:	b8 0d 00 00 00       	mov    $0xd,%eax
 8f8:	cd 40                	int    $0x40
 8fa:	c3                   	ret    

000008fb <uptime>:
SYSCALL(uptime)
 8fb:	b8 0e 00 00 00       	mov    $0xe,%eax
 900:	cd 40                	int    $0x40
 902:	c3                   	ret    

00000903 <settickets>:
SYSCALL(settickets)
 903:	b8 16 00 00 00       	mov    $0x16,%eax
 908:	cd 40                	int    $0x40
 90a:	c3                   	ret    

0000090b <getpinfo>:
SYSCALL(getpinfo)
 90b:	b8 17 00 00 00       	mov    $0x17,%eax
 910:	cd 40                	int    $0x40
 912:	c3                   	ret    
 913:	66 90                	xchg   %ax,%ax
 915:	66 90                	xchg   %ax,%ax
 917:	66 90                	xchg   %ax,%ax
 919:	66 90                	xchg   %ax,%ax
 91b:	66 90                	xchg   %ax,%ax
 91d:	66 90                	xchg   %ax,%ax
 91f:	90                   	nop

00000920 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 920:	55                   	push   %ebp
 921:	89 e5                	mov    %esp,%ebp
 923:	57                   	push   %edi
 924:	56                   	push   %esi
 925:	53                   	push   %ebx
 926:	83 ec 3c             	sub    $0x3c,%esp
 929:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 92c:	89 d1                	mov    %edx,%ecx
{
 92e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 931:	85 d2                	test   %edx,%edx
 933:	0f 89 7f 00 00 00    	jns    9b8 <printint+0x98>
 939:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 93d:	74 79                	je     9b8 <printint+0x98>
    neg = 1;
 93f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 946:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 948:	31 db                	xor    %ebx,%ebx
 94a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 94d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 950:	89 c8                	mov    %ecx,%eax
 952:	31 d2                	xor    %edx,%edx
 954:	89 cf                	mov    %ecx,%edi
 956:	f7 75 c4             	divl   -0x3c(%ebp)
 959:	0f b6 92 ec 0e 00 00 	movzbl 0xeec(%edx),%edx
 960:	89 45 c0             	mov    %eax,-0x40(%ebp)
 963:	89 d8                	mov    %ebx,%eax
 965:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 968:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 96b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 96e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 971:	76 dd                	jbe    950 <printint+0x30>
  if(neg)
 973:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 976:	85 c9                	test   %ecx,%ecx
 978:	74 0c                	je     986 <printint+0x66>
    buf[i++] = '-';
 97a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 97f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 981:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 986:	8b 7d b8             	mov    -0x48(%ebp),%edi
 989:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 98d:	eb 07                	jmp    996 <printint+0x76>
 98f:	90                   	nop
    putc(fd, buf[i]);
 990:	0f b6 13             	movzbl (%ebx),%edx
 993:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 996:	83 ec 04             	sub    $0x4,%esp
 999:	88 55 d7             	mov    %dl,-0x29(%ebp)
 99c:	6a 01                	push   $0x1
 99e:	56                   	push   %esi
 99f:	57                   	push   %edi
 9a0:	e8 de fe ff ff       	call   883 <write>
  while(--i >= 0)
 9a5:	83 c4 10             	add    $0x10,%esp
 9a8:	39 de                	cmp    %ebx,%esi
 9aa:	75 e4                	jne    990 <printint+0x70>
}
 9ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
 9af:	5b                   	pop    %ebx
 9b0:	5e                   	pop    %esi
 9b1:	5f                   	pop    %edi
 9b2:	5d                   	pop    %ebp
 9b3:	c3                   	ret    
 9b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 9b8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 9bf:	eb 87                	jmp    948 <printint+0x28>
 9c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 9c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 9cf:	90                   	nop

000009d0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 9d0:	55                   	push   %ebp
 9d1:	89 e5                	mov    %esp,%ebp
 9d3:	57                   	push   %edi
 9d4:	56                   	push   %esi
 9d5:	53                   	push   %ebx
 9d6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 9d9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 9dc:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 9df:	0f b6 13             	movzbl (%ebx),%edx
 9e2:	84 d2                	test   %dl,%dl
 9e4:	74 6a                	je     a50 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
 9e6:	8d 45 10             	lea    0x10(%ebp),%eax
 9e9:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 9ec:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 9ef:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
 9f1:	89 45 d0             	mov    %eax,-0x30(%ebp)
 9f4:	eb 36                	jmp    a2c <printf+0x5c>
 9f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 9fd:	8d 76 00             	lea    0x0(%esi),%esi
 a00:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 a03:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
 a08:	83 f8 25             	cmp    $0x25,%eax
 a0b:	74 15                	je     a22 <printf+0x52>
  write(fd, &c, 1);
 a0d:	83 ec 04             	sub    $0x4,%esp
 a10:	88 55 e7             	mov    %dl,-0x19(%ebp)
 a13:	6a 01                	push   $0x1
 a15:	57                   	push   %edi
 a16:	56                   	push   %esi
 a17:	e8 67 fe ff ff       	call   883 <write>
 a1c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
 a1f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 a22:	0f b6 13             	movzbl (%ebx),%edx
 a25:	83 c3 01             	add    $0x1,%ebx
 a28:	84 d2                	test   %dl,%dl
 a2a:	74 24                	je     a50 <printf+0x80>
    c = fmt[i] & 0xff;
 a2c:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 a2f:	85 c9                	test   %ecx,%ecx
 a31:	74 cd                	je     a00 <printf+0x30>
      }
    } else if(state == '%'){
 a33:	83 f9 25             	cmp    $0x25,%ecx
 a36:	75 ea                	jne    a22 <printf+0x52>
      if(c == 'd'){
 a38:	83 f8 25             	cmp    $0x25,%eax
 a3b:	0f 84 07 01 00 00    	je     b48 <printf+0x178>
 a41:	83 e8 63             	sub    $0x63,%eax
 a44:	83 f8 15             	cmp    $0x15,%eax
 a47:	77 17                	ja     a60 <printf+0x90>
 a49:	ff 24 85 94 0e 00 00 	jmp    *0xe94(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 a50:	8d 65 f4             	lea    -0xc(%ebp),%esp
 a53:	5b                   	pop    %ebx
 a54:	5e                   	pop    %esi
 a55:	5f                   	pop    %edi
 a56:	5d                   	pop    %ebp
 a57:	c3                   	ret    
 a58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a5f:	90                   	nop
  write(fd, &c, 1);
 a60:	83 ec 04             	sub    $0x4,%esp
 a63:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 a66:	6a 01                	push   $0x1
 a68:	57                   	push   %edi
 a69:	56                   	push   %esi
 a6a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 a6e:	e8 10 fe ff ff       	call   883 <write>
        putc(fd, c);
 a73:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 a77:	83 c4 0c             	add    $0xc,%esp
 a7a:	88 55 e7             	mov    %dl,-0x19(%ebp)
 a7d:	6a 01                	push   $0x1
 a7f:	57                   	push   %edi
 a80:	56                   	push   %esi
 a81:	e8 fd fd ff ff       	call   883 <write>
        putc(fd, c);
 a86:	83 c4 10             	add    $0x10,%esp
      state = 0;
 a89:	31 c9                	xor    %ecx,%ecx
 a8b:	eb 95                	jmp    a22 <printf+0x52>
 a8d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 a90:	83 ec 0c             	sub    $0xc,%esp
 a93:	b9 10 00 00 00       	mov    $0x10,%ecx
 a98:	6a 00                	push   $0x0
 a9a:	8b 45 d0             	mov    -0x30(%ebp),%eax
 a9d:	8b 10                	mov    (%eax),%edx
 a9f:	89 f0                	mov    %esi,%eax
 aa1:	e8 7a fe ff ff       	call   920 <printint>
        ap++;
 aa6:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 aaa:	83 c4 10             	add    $0x10,%esp
      state = 0;
 aad:	31 c9                	xor    %ecx,%ecx
 aaf:	e9 6e ff ff ff       	jmp    a22 <printf+0x52>
 ab4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 ab8:	8b 45 d0             	mov    -0x30(%ebp),%eax
 abb:	8b 10                	mov    (%eax),%edx
        ap++;
 abd:	83 c0 04             	add    $0x4,%eax
 ac0:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 ac3:	85 d2                	test   %edx,%edx
 ac5:	0f 84 8d 00 00 00    	je     b58 <printf+0x188>
        while(*s != 0){
 acb:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
 ace:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
 ad0:	84 c0                	test   %al,%al
 ad2:	0f 84 4a ff ff ff    	je     a22 <printf+0x52>
 ad8:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 adb:	89 d3                	mov    %edx,%ebx
 add:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 ae0:	83 ec 04             	sub    $0x4,%esp
          s++;
 ae3:	83 c3 01             	add    $0x1,%ebx
 ae6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 ae9:	6a 01                	push   $0x1
 aeb:	57                   	push   %edi
 aec:	56                   	push   %esi
 aed:	e8 91 fd ff ff       	call   883 <write>
        while(*s != 0){
 af2:	0f b6 03             	movzbl (%ebx),%eax
 af5:	83 c4 10             	add    $0x10,%esp
 af8:	84 c0                	test   %al,%al
 afa:	75 e4                	jne    ae0 <printf+0x110>
      state = 0;
 afc:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 aff:	31 c9                	xor    %ecx,%ecx
 b01:	e9 1c ff ff ff       	jmp    a22 <printf+0x52>
 b06:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 b0d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 b10:	83 ec 0c             	sub    $0xc,%esp
 b13:	b9 0a 00 00 00       	mov    $0xa,%ecx
 b18:	6a 01                	push   $0x1
 b1a:	e9 7b ff ff ff       	jmp    a9a <printf+0xca>
 b1f:	90                   	nop
        putc(fd, *ap);
 b20:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
 b23:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 b26:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 b28:	6a 01                	push   $0x1
 b2a:	57                   	push   %edi
 b2b:	56                   	push   %esi
        putc(fd, *ap);
 b2c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 b2f:	e8 4f fd ff ff       	call   883 <write>
        ap++;
 b34:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 b38:	83 c4 10             	add    $0x10,%esp
      state = 0;
 b3b:	31 c9                	xor    %ecx,%ecx
 b3d:	e9 e0 fe ff ff       	jmp    a22 <printf+0x52>
 b42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 b48:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 b4b:	83 ec 04             	sub    $0x4,%esp
 b4e:	e9 2a ff ff ff       	jmp    a7d <printf+0xad>
 b53:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 b57:	90                   	nop
          s = "(null)";
 b58:	ba 8d 0e 00 00       	mov    $0xe8d,%edx
        while(*s != 0){
 b5d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 b60:	b8 28 00 00 00       	mov    $0x28,%eax
 b65:	89 d3                	mov    %edx,%ebx
 b67:	e9 74 ff ff ff       	jmp    ae0 <printf+0x110>
 b6c:	66 90                	xchg   %ax,%ax
 b6e:	66 90                	xchg   %ax,%ax

00000b70 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b70:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b71:	a1 88 12 00 00       	mov    0x1288,%eax
{
 b76:	89 e5                	mov    %esp,%ebp
 b78:	57                   	push   %edi
 b79:	56                   	push   %esi
 b7a:	53                   	push   %ebx
 b7b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 b7e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 b88:	89 c2                	mov    %eax,%edx
 b8a:	8b 00                	mov    (%eax),%eax
 b8c:	39 ca                	cmp    %ecx,%edx
 b8e:	73 30                	jae    bc0 <free+0x50>
 b90:	39 c1                	cmp    %eax,%ecx
 b92:	72 04                	jb     b98 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b94:	39 c2                	cmp    %eax,%edx
 b96:	72 f0                	jb     b88 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 b98:	8b 73 fc             	mov    -0x4(%ebx),%esi
 b9b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 b9e:	39 f8                	cmp    %edi,%eax
 ba0:	74 30                	je     bd2 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 ba2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 ba5:	8b 42 04             	mov    0x4(%edx),%eax
 ba8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 bab:	39 f1                	cmp    %esi,%ecx
 bad:	74 3a                	je     be9 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 baf:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 bb1:	5b                   	pop    %ebx
  freep = p;
 bb2:	89 15 88 12 00 00    	mov    %edx,0x1288
}
 bb8:	5e                   	pop    %esi
 bb9:	5f                   	pop    %edi
 bba:	5d                   	pop    %ebp
 bbb:	c3                   	ret    
 bbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bc0:	39 c2                	cmp    %eax,%edx
 bc2:	72 c4                	jb     b88 <free+0x18>
 bc4:	39 c1                	cmp    %eax,%ecx
 bc6:	73 c0                	jae    b88 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 bc8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 bcb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 bce:	39 f8                	cmp    %edi,%eax
 bd0:	75 d0                	jne    ba2 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 bd2:	03 70 04             	add    0x4(%eax),%esi
 bd5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 bd8:	8b 02                	mov    (%edx),%eax
 bda:	8b 00                	mov    (%eax),%eax
 bdc:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 bdf:	8b 42 04             	mov    0x4(%edx),%eax
 be2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 be5:	39 f1                	cmp    %esi,%ecx
 be7:	75 c6                	jne    baf <free+0x3f>
    p->s.size += bp->s.size;
 be9:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 bec:	89 15 88 12 00 00    	mov    %edx,0x1288
    p->s.size += bp->s.size;
 bf2:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 bf5:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 bf8:	89 0a                	mov    %ecx,(%edx)
}
 bfa:	5b                   	pop    %ebx
 bfb:	5e                   	pop    %esi
 bfc:	5f                   	pop    %edi
 bfd:	5d                   	pop    %ebp
 bfe:	c3                   	ret    
 bff:	90                   	nop

00000c00 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 c00:	55                   	push   %ebp
 c01:	89 e5                	mov    %esp,%ebp
 c03:	57                   	push   %edi
 c04:	56                   	push   %esi
 c05:	53                   	push   %ebx
 c06:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c09:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 c0c:	8b 3d 88 12 00 00    	mov    0x1288,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c12:	8d 70 07             	lea    0x7(%eax),%esi
 c15:	c1 ee 03             	shr    $0x3,%esi
 c18:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 c1b:	85 ff                	test   %edi,%edi
 c1d:	0f 84 9d 00 00 00    	je     cc0 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c23:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 c25:	8b 4a 04             	mov    0x4(%edx),%ecx
 c28:	39 f1                	cmp    %esi,%ecx
 c2a:	73 6a                	jae    c96 <malloc+0x96>
 c2c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 c31:	39 de                	cmp    %ebx,%esi
 c33:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 c36:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 c3d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 c40:	eb 17                	jmp    c59 <malloc+0x59>
 c42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c48:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 c4a:	8b 48 04             	mov    0x4(%eax),%ecx
 c4d:	39 f1                	cmp    %esi,%ecx
 c4f:	73 4f                	jae    ca0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 c51:	8b 3d 88 12 00 00    	mov    0x1288,%edi
 c57:	89 c2                	mov    %eax,%edx
 c59:	39 d7                	cmp    %edx,%edi
 c5b:	75 eb                	jne    c48 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 c5d:	83 ec 0c             	sub    $0xc,%esp
 c60:	ff 75 e4             	push   -0x1c(%ebp)
 c63:	e8 83 fc ff ff       	call   8eb <sbrk>
  if(p == (char*)-1)
 c68:	83 c4 10             	add    $0x10,%esp
 c6b:	83 f8 ff             	cmp    $0xffffffff,%eax
 c6e:	74 1c                	je     c8c <malloc+0x8c>
  hp->s.size = nu;
 c70:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 c73:	83 ec 0c             	sub    $0xc,%esp
 c76:	83 c0 08             	add    $0x8,%eax
 c79:	50                   	push   %eax
 c7a:	e8 f1 fe ff ff       	call   b70 <free>
  return freep;
 c7f:	8b 15 88 12 00 00    	mov    0x1288,%edx
      if((p = morecore(nunits)) == 0)
 c85:	83 c4 10             	add    $0x10,%esp
 c88:	85 d2                	test   %edx,%edx
 c8a:	75 bc                	jne    c48 <malloc+0x48>
        return 0;
  }
}
 c8c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 c8f:	31 c0                	xor    %eax,%eax
}
 c91:	5b                   	pop    %ebx
 c92:	5e                   	pop    %esi
 c93:	5f                   	pop    %edi
 c94:	5d                   	pop    %ebp
 c95:	c3                   	ret    
    if(p->s.size >= nunits){
 c96:	89 d0                	mov    %edx,%eax
 c98:	89 fa                	mov    %edi,%edx
 c9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 ca0:	39 ce                	cmp    %ecx,%esi
 ca2:	74 4c                	je     cf0 <malloc+0xf0>
        p->s.size -= nunits;
 ca4:	29 f1                	sub    %esi,%ecx
 ca6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 ca9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 cac:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 caf:	89 15 88 12 00 00    	mov    %edx,0x1288
}
 cb5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 cb8:	83 c0 08             	add    $0x8,%eax
}
 cbb:	5b                   	pop    %ebx
 cbc:	5e                   	pop    %esi
 cbd:	5f                   	pop    %edi
 cbe:	5d                   	pop    %ebp
 cbf:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 cc0:	c7 05 88 12 00 00 8c 	movl   $0x128c,0x1288
 cc7:	12 00 00 
    base.s.size = 0;
 cca:	bf 8c 12 00 00       	mov    $0x128c,%edi
    base.s.ptr = freep = prevp = &base;
 ccf:	c7 05 8c 12 00 00 8c 	movl   $0x128c,0x128c
 cd6:	12 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 cd9:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 cdb:	c7 05 90 12 00 00 00 	movl   $0x0,0x1290
 ce2:	00 00 00 
    if(p->s.size >= nunits){
 ce5:	e9 42 ff ff ff       	jmp    c2c <malloc+0x2c>
 cea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 cf0:	8b 08                	mov    (%eax),%ecx
 cf2:	89 0a                	mov    %ecx,(%edx)
 cf4:	eb b9                	jmp    caf <malloc+0xaf>
