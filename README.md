### Installation

This is an x86_64 environment with Ubuntu LTS 24.04.

First, install **colima** and **docker**:
`brew install colima`
`brew install docker`

Also install the **buildx** plugin for docker:
`brew install docker-buildx`

And then run:
`colima start --vm-type=vz --arch aarch64 --cpu 2 --memory 1 --mount-type=virtiofs --edit`

**NB**: make sure the 'rosetta' option is set to true to enable it to emulate x86_64 with Rosetta2 when necessary.
This will start a lightweight colima aarch64 linux VM with Apple's native virtualization for the Docker Engine/Daemon to run on. It uses Lima as a backend.
Modify cpu and memory to accomodate your needs. The integer values specify GiB. Virtiofs is the default `vz` io type.

Befire we build the container, set up the Docker Buildx Builder:

1.  Create and Use a Buildx Builder:
    ```bash
    docker buildx create --name colima-builder --driver docker-container --use
    ```
    (If you encounter `unknown flag: --name`, ensure `docker-buildx` is fully updated via `brew upgrade docker docker-buildx`, then restart your terminal and try again.)

2.  **Bootstrap the Builder:**
    ```bash
    docker buildx inspect colima-builder --bootstrap
    ```

Next, build the docker image using the Dockerfile. _**Run from the directory with the Dockerfile**_
`docker buildx build --platform linux/amd64 -t ultsx86_64:24.04 .`

Now, run an interactive shell from the container and move all files from current host machine directory to `/workspace` in the container:
`docker run --platform linux/amd64 -it -v ./home:/workspace ultsx86_64:24.04 bash`

(The `-v ./home:/workspace` part mounts the `./home` subdirectory of your current host directory into `/workspace` inside the container, allowing you to access your project files.)

**Inside the container:**
* Your custom Bash prompt should be active.
* Your project files will be located at `/workspace`.
* Verify tools: `gdb --version`, `gcc --version`, `nasm -v`, etc.
