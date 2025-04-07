Project Deployment
=========

This role allows you to deploy docker projects via docker compose files.

It also installs the [Docker SDK for Python](https://pypi.org/project/docker/) and uninstalls `docker-py` if installed.
You can disable this behavior by setting `project_deployment_install_python_requirements: false`.

Requirements
------------

`docker` and `docker-compose` (or `docker compose` - adjust via `project_deployment_docker_compose_command` variable)

Role Variables
--------------

The default version of docker-compose files. Can be overridden on a per project basis. You can also leave this unset, to not set a version in the docker-compose file.

    project_deployment_docker_compose_file_version: "2"

The command to use to start and stop the containers via docker-compose

    project_deployment_docker_compose_command: "docker-compose"

Configure where to store the project files:

    project_deployment_base_path: "/opt/project_deployment_projects"

Configure owner and access modes:

    project_deployment_file_mode: "0664"
    project_deployment_directory_mode: "0775"
    project_deployment_secret_file_mode: "0660"
    project_deployment_secret_directory_mode: "0770"

    project_deployment_owner: "{{ ansible_user }}"
    project_deployment_group: "{{ ansible_user }}"

    project_deployment_permission_overrides: {}
    # This is a dictionary of dictionaries, where the key is the absolute path to the file or directory on the remote host,
    # and the value is a dictionary with the following keys:
    # - mode: The mode to set (e.g. "0644")
    # - owner: The owner to set (e.g. "root")
    # - group: The group to set (e.g. "root")

The docker projects to be deployed:

    project_deployment_projects_to_deploy: ["project1"] (leave empty to deploy all )

    project_deployment_projects:
      project1:
        docker_compose_file_version:
        services:
          service1:
            # service configuration options
          service2:
          ...
        networks:
          network1:
            # network configuration options
          network2:
        regex_secret_remote_paths:
          - regex1
          - ...
        regex_ignore_changes_remote_paths:
          - regex1
          - ...
      project2:
        ...

Currently supported docker-compose keys are:
- image
- platform
- container_name
- privileged
- user
- init
- command
- mem_limit
- network_mode
- entrypoint
- stop_grace_period
- stop_signal
- runtime
- scale
- restart
- networks
- depends_on
- dns
- dns_opt
- dns_search
- environment
- env_file
- expose
- ports
- devices
- labels
- volumes
- sysctls
- logging
- healthcheck

### files and templates

Often docker projects are deployed in combination with different files. To accomodate for this, you can put your files or templates into the following directories, to deploy them alongside the docker-compose files.

```yaml
- playbook_dir + '/docker-project-deployment/files/' + project_name (files will be deployed for every project with matching project_name.)

- playbook_dir + '/docker-project-deployment/templates/' + project_name (templates will be deployed for every project with matching project_name. Templates can have the .j2 file extension, which will be stripped on deployment, but it isn't required.)

- playbook_dir + '/docker-project-deployment/host_files/' + inventory_hostname + '/' + project_name (files will be deployed for a the host `inventory_hostname` and for the project `project_name` only.)
```

Host-specific files will always be deployed. If a file or template has the same remote path as a host-file only the host-file will be deployed.

Subdirectories will also be deployed to the host(s). e.g.:

```
| ansible.cfg
| playbook.yml
|
└───docker-project-deployment
|   └───files
|       └───project1
|           └─── dir1
|                | file1
└───group_vars
|   | ...
└───host_vars
|   | ...
└─── roles
|   | ...
```
will lead to `{{ project_deployment_base_path }}/project1/dir1/file1` on the host.

For more information take a look at `defaults/main.yml`

Dependencies
------------

None

Example Playbook
----------------
Example deployment of [traefik](https://github.com/traefik/traefik-library-image) to an EC2 instance can be found [here](https://github.com/ifalatik/ec2-traefik-demo).
