# v2.2.0

## project_deployment
- becoming super user is no longer required for the entire role, instead select tasks become where necessary

# v2.1.1

## project_deployment
- fix `restart`, `condition` and `required` at `depends_on` key for services

# v2.1.0

## project_deployment
- add `restart`, `condition` and `required` to `depends_on` key for services

# v2.0.1

## project_deployment
- rename `project_deployment_project_to_deploy` -> `project_deployment_projects_to_deploy`

# v2.0.0

## project_deployment
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

# v1.0.4

## project_deployment

- don't become for localhost tasks

# v1.0.3

## project_deployment
- indent healthcheck test into newline if colon occurs
- fix test
- some ansible-lint proposed fixes

# v1.0.2

## project_deployment
- fix name for filters

# v1.0.1
- fix CHANGELOG

# v1.0.0
- import role ifalatik.docker_project_deployment at v1.2.3
- for previous CHANGELOG look at roles/project_deployment/CHANGELOG.md
