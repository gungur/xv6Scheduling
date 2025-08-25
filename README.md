# xv6 Scheduling Project

This project involves modifying the xv6 operating system to implement and test different CPU scheduling algorithms. The provided setup uses Docker to create a consistent development environment for building and running xv6.

## Project Overview

The goal of this project is to implement and analyze different CPU scheduling algorithms in xv6. The project includes:

- **Dockerized development environment** for consistent builds
- **Testing framework** with multiple test cases
- **Process statistics collection** for analyzing scheduler behavior
- **Round-robin and stride scheduling** implementations

Key files include:
- `rr_process_stats.csv` and `stride_process_stats.csv`: Scheduler performance data
- Multiple test cases (`test_1.c`, `test_2.c`, `test_3.c`) for validation
- Helper scripts for building and testing

## Prerequisites

- **Docker**: Required for containerized development environment
- **Docker Compose**: For managing the container environment
- **Git**: For version control and cloning the repository

## Setup Instructions

### 1. Install Docker

Follow the official Docker installation guide for your platform:
[https://docs.docker.com/engine/install/](https://docs.docker.com/engine/install/)

Verify your installation:
```bash
docker run hello-world
docker compose version
```

### 2. Clone and Setup the Project

```bash
git clone <repository-url>
cd <project-directory>
```

### 3. Build the Docker Image

```bash
docker build -t cs537-v1 --platform=linux/amd64 .
```

Verify the image was created:
```bash
docker images
```

### 4. Start the Development Environment

```bash
docker compose up -d
```

Verify the container is running:
```bash
docker ps -a
```

### 5. Access the Container

```bash
docker exec -it cs537 bash
```

## Running xv6

1. Copy your `xv6-public` folder to the host's `cs537` directory (this automatically syncs with the container)
2. Inside the container, navigate to the xv6 directory:
   ```bash
   cd /cs537/xv6-public
   ```
3. Build and run xv6:
   ```bash
   make qemu-nox
   ```

## Testing Framework

The project includes a comprehensive testing framework to validate your scheduler implementation.

### Running Tests

Execute all tests:
```bash
./run-tests.sh
```

Test options:
- `-h`: Show help message
- `-v`: Verbose output
- `-t n`: Run only test n
- `-c`: Continue after failures
- `-d testdir`: Use alternative test directory
- `-s`: Skip pre-test initialization

### Test Structure

Tests are located in `tests/tests/` with the following files for each test number `n`:
- `n.rc`: Expected return code
- `n.out`: Expected standard output
- `n.err`: Expected standard error  
- `n.run`: Test execution command
- `n.desc`: Test description
- `n.pre`/`n.post`: Optional setup/cleanup scripts

### Available Tests

1. **Test 1**: Verifies process statistics collection and default ticket allocation
2. **Test 2**: Validates pass value incrementation according to stride scheduling
3. **Test 3**: Tests proportional sharing between parent and child processes

## Adding New Tests

To add a new test case:

1. Create `test_n.c` in the `tests/tests/` directory
2. Add the expected output files (`n.rc`, `n.out`, `n.err`)
3. Create `n.run` with the test execution command
4. Add a description in `n.desc`
5. Update the `pre` file to include your test (follow existing patterns)

Run your new test:
```bash
./run-tests.sh -t n
```

## Troubleshooting

### Common Issues

1. **Docker permission denied**: Add your user to the docker group or use sudo
2. **Container won't start**: Check if ports are already in use
3. **xv6 build failures**: Ensure all dependencies are installed in the container
4. **Test failures**: Verify your scheduler implementation matches expected behavior

### Getting Help

- Check the [xv6 documentation](https://pdos.csail.mit.edu/6.828/2014/xv6.html)
- Review the provided test cases for implementation guidance
- Consult the CSL Docker documentation for machine-specific issues

### Container Management

Stop the container when not in use:
```bash
docker stop cs537
```

Restart later:
```bash
docker start cs537
docker exec -it cs537 bash
```

## 📊 Performance Analysis

The project includes CSV files (`rr_process_stats.csv` and `stride_process_stats.csv`) that capture scheduler performance metrics. These can be analyzed to understand:

- CPU time allocation across processes
- Ticket distribution effects on scheduling
- Pass value progression in stride scheduling
- Runtime comparisons between different scheduling algorithms

Use these data files to validate your implementation and analyze the behavior of your scheduler under different workloads.
