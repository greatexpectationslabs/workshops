## Run the workshop Postgres database and GX Agent

1. Install [Docker Desktop](https://www.docker.com/products/docker-desktop/) and [verify that Docker is running on your local machine](https://docs.docker.com/config/daemon/troubleshoot/#check-whether-docker-is-running).

2. Clone this workshop repo to your local machine.
   ```
   git clone git@github.com:greatexpectationslabs/workshops.git
   ```

3. `cd` to the `get_started_with_gx_cloud_and_postgres` subdirectory of the cloned repo.

4. Using the following command, replace `<your-organization-id>` and `<your-access-token>` with the values of your GX Cloud organization id and access token, respectively. Execute the command in your terminal to run the Postgres instance and GX Agent using Docker Compose.
   ```
   GX_CLOUD_ORGANIZATION_ID="<your-organization-id>" GX_CLOUD_ACCESS_TOKEN="<your-access-token>" docker compose up
   ```

5. Your connection string when creating the Postgres Data Source in the GX Cloud UI is:
   ```
   postgresql://example_user@db/gx_example_db
   ```

6. To stop the running Docker Compose, `cd` to the `get_started_with_gx_cloud_and_postgres` subdirectory of the cloned repo, and run:
   ```
   docker compose down
   ```