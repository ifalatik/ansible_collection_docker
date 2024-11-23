# CHANGELOG

## v3.1.0

### project_deployment
- deploy value of `command` as a list wrapping multiple lines instead of
a single line list value, if the value is passed to the role as a list
    - if the value is a string, nothing changes
    - this helps with some YAML string escapes, where it's easier to write the command as a list

## v3.0.7

### project_deployment
- properly escape ':' in single value variables using double quotes
    - this doesn't change how the image is deployed even when specifying a tag

## v3.0.6

### project_deployment
- Add `user` key to compose

## v3.0.5

### project_deployment
- Fix python3-pip not being installed as become_user (root)
- Remove unused handler outputs
- Refactor: consistent usage of become
- Refactor: remove unused become: false
- Fix: become `project_deployment_docker_user` when creating docker networks

## v3.0.4

### project_deployment
- Fix `labels` section being defined twice in `docker-compose.yml` when `labels` is a dictionary.

## v3.0.3

### project_deployment
- Fix docker-compose file generation when `roject_deployment_projects.<project>.networks` is defined.

## v3.0.2

### project_deployment
- Fix a bug when a network is defined as external but no labels were set.

## v3.0.1

### project_deployment
- Update README

## v3.0.0

### project_deployment

#### Breaking Changes
- Deprecate `project_deployment_projects.<project>.external_networks` in favor of `project_deployment_projects.<project>.networks`.
    - The role execution will fail if `external_networks` is set.
    - To migrate, set `networks.<network>.external: true` in the `networks` key of the project.
- Add network configuration options via `project_deployment_projects.<project>.networks`.
    - Supports the same syntax and options as normal docker-compose networks. [Reference](https://docs.docker.com/reference/compose-file/networks/)

#### General Improvements
- Remove empty new line from deployed docker-compose.yml before the `services` key, if no `version` is set.

## v2.3.7

### project_deployment
- ensure role doesn't crash in check mode if python3-pip isn't installed

## v2.3.6

### project_deployment
- Ensure python3-pip is installed when `project_deployment_install_python_requirements` is `true`

## v2.3.5

### project_deployment
- add check whether `logging` is set to `none` for a service (thanks to @serknsvnc)
    - if so, don't write `logging` key to docker-compose.yml for that service
    - previously this would crash with `ansible.errors.AnsibleUndefinedVariable: 'None' has no attribute 'driver'. 'None' has no attribute 'driver'`

## v2.3.4

### project_deployment
- remove `version` key from docker-compose.yml unless explicitely stated via `project_deployment_docker_compose_file_version` or `<project>.docker_compose_file_version`
- allow using docker-compose.yml host-files without deploying the template
- add `project_deployment_install_python_requirements` (default `true`) which will control whether to install the [Docker SDK for Python](https://pypi.org/project/docker/) and uninstall `docker-py` if installed.
- switch to using the `community.docker.docker_compose_v2` module for stopping and starting projects

## v2.3.3

### project_deployment
- add `--remove-orphans` parameter to container restarting process to allow for container name changes

## v2.3.2

### project_deployment
- add `project_deployment_docker_user` variable, which allows restarting the projects as a different user than `{{ ansible_user }}`/`root`

## v2.3.1

### project_deployment
- allow `regex_ignore_changes_remote_paths` to ignore changes in docker-compose.yml
- add `memswap_limit` support

## v2.3.0

### project_deployment
- add key `regex_ignore_changes_remote_paths` to projects, which allows the user to select certain files, for which the docker project shouldn't be restarted if they change.
- add example for `regex_ignore_changes_remote_paths` in README

## v2.2.0

### project_deployment
- becoming super user is no longer required for the entire role, instead select tasks become where necessary

## v2.1.1

### project_deployment
- fix `restart`, `condition` and `required` at `depends_on` key for services

## v2.1.0

### project_deployment
- add `restart`, `condition` and `required` to `depends_on` key for services

## v2.0.1

### project_deployment
- rename `project_deployment_project_to_deploy` -> `project_deployment_projects_to_deploy`

## v2.0.0

### project_deployment
- rename variables to match ansible-lint:
    - `docker_compose_file_version` -> `project_deployment_docker_compose_file_version`
    - `docker_compose_command` -> `project_deployment_docker_compose_command`
    - `docker_project_base_path` -> `project_deployment_base_path`
    - `docker_file_mode` -> `project_deployment_file_mode`
    - `docker_directory_mode` -> `project_deployment_directory_mode`
    - `docker_secret_file_mode` -> `project_deployment_secret_file_mode`
    - `docker_secret_directory_mode` -> `project_deployment_secret_directory_mode`
    - `docker_owner` -> `project_deployment_owner`
    - `docker_group` -> `project_deployment_group`
    - `docker_projects_to_deploy` -> `project_deployment_project_to_deploy`
    - `docker_projects` -> `project_deployment_projects`

## v1.0.4

### project_deployment

- don't become for localhost tasks

## v1.0.3

### project_deployment
- indent healthcheck test into newline if colon occurs
- fix test
- some ansible-lint proposed fixes

## v1.0.2

### project_deployment
- fix name for filters

## v1.0.1
- fix CHANGELOG

## v1.0.0
- import role ifalatik.docker_project_deployment at v1.2.3
- for previous CHANGELOG look at roles/project_deployment/CHANGELOG.md

# CHANGELOG for ifalatik.docker_project_deployment role

## 1.2.3
- fix remote_path for files being wrong when `project_name/` was in the local path.

## 1.2.2
- add extra_hosts list var to docker-compose.yml

## 1.2.1
- hide diff when remote_path matches secret path

## 1.2.0
- fix deployment of templates

## 1.1.2
- allow for empty healthcheck in project

## 1.1.1
- fix typo in ansible task

## 1.1.0
- add option to only deploy a subset of projects via `docker_projects_to_deploy` variable

## 1.0.1
- fix bug tracker URL

## 1.0.0
- Initial Release

