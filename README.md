## Setup
This is an x86_64 environment running Ubuntu LTS 24.04 for ARM macOS machines. Uses [colima] and [docker].
It contains a minimal installation of Ubuntu with `gdb`, `gcc`, `binutils`, `nasm` and basic utils.

### Requirements
You need to have [homebrew] installed.

### Running the container

To access the container via an interactive shell simply run:
```bash
./run
```

Which executes the `docker run` command:
```bash
docker run --platform linux/amd64 -it -v ./home:/workspace ultsx86_64:24.04 bash
```

(`-v ./home:/workspace` part mounts `./home` of your host machine into `/workspace` inside the container.)

### Installation

1. install **colima** and **docker**:
```bash
brew install colima
```
```bash
brew install docker
```

Also install the **buildx** plugin for docker:
```bash
brew install docker-buildx
```

2. Create the Colima VM for Docker:
```bash
colima start --vm-type=vz --arch aarch64 --cpu 2 --memory 1 --mount-type=virtiofs --edit
```

**NB**: Make sure the 'rosetta' option is set to true to enable it to emulate x86_64 with Rosetta2 when necessary.

This will start a lightweight colima aarch64 linux VM with Apple's native virtualization for the Docker Engine/Daemon to run on. It uses Lima as a backend.
Modify cpu and memory to accomodate your needs. The integer values specify GiB. Virtiofs is the default `vz` io type.

3. Before we build the container, set up the Docker Buildx Builder:

    1.  Create and Use a Buildx Builder:
        ```bash
        docker buildx create --name colima-builder --driver docker-container --use
        ```
        (If you encounter `unknown flag: --name`, ensure `docker-buildx` is fully updated via `brew upgrade docker docker-buildx`, then restart your terminal and try again.)
    
    2.  Bootstrap the Builder:
        ```bash
        docker buildx inspect colima-builder --bootstrap
        ```

4. Build the docker image using the Dockerfile. _**Run from the directory with the Dockerfile**_
```bash
docker buildx build --platform linux/amd64 -t ultsx86_64:24.04 .
```

[colima]:https://github.com/abiosoft/colima
[docker]:https://www.docker.com
[homebrew]:https://brew.sh
