# Get Started with GX Cloud and Databricks SQL

*This workshop content is current as of 20 September 2024.*

Welcome to our workshop! In this workshop, you'll learn how to connect your GX Cloud account to a Databricks SQL Data Source, create Expectations, and run Validations.

## Prerequisites
- A [GX Cloud](https://hubs.li/Q02mpbXd0) account with Admin or Editor permissions.

## Agenda
You'll complete the following tasks in this workshop:

1. [Sign in to GX Cloud](#sign-in-to-gx-cloud)
1. [Create a Databricks SQL Data Source and Data Asset](#create-a-databricks-sql-data-source-and-data-asset)
1. [Create Expectations](#create-expectations)
1. [Validate Expectations](#validate-a-data-asset)
1. [Update the failing Expectation and run the Validation again](#update-the-failing-expectation-and-run-the-validation-again)
1. [Profile Data](#profile-data)

## GX terminology
If you're new to GX, an understanding of the following [GX terminology](https://docs.greatexpectations.io/docs/reference/learn/glossary#) will be helpful as you complete this workshop.

<img src="../common/img/gx_terminology.png" alt="Introductory GX terminology" style="width:800px;"/><br>

## Sign in to GX Cloud
Sign in to [GX Cloud](https://hubs.li/Q02mpbXd0).

## Create a Databricks SQL Data Source and Data Asset
You can connect to Databricks SQL from GX Cloud by creating a Data Source and Data Asset.

> **Create a Databricks SQL Data Source**
> 1. In GX Cloud, click **Data Assets** > **New Data Asset**, if this is your first time using GX Cloud, the **Data Assets** page will prompt to create a **Data Source**.
> 1. Click **Databricks SQL**.
> 1. Configure the Databricks SQL Data Source connection:
>
>    * In the **Data Source name** field, enter a name. For example, `GX Workshop Databricks`.
>    * In the **Connection** field, enter the Databricks SQL connection string:
>        `databricks://token:dapi3ae6f4396df7598eb1385e7f2fdd041e@dbc-8ad5a215-e8c7.cloud.databricks.com:443?http_path=/sql/1.0/warehouses/7d508f960af23038&catalog=workshops&schema=nyctaxi`
> 1. Click **Connect**.
> If you get a connection error, our shared token may have expired, or the Databricks Warehouse may not be running yet. Please try again after a couple minutes and if the error persists, please [open a Support ticket](https://support.greatexpectations.io/hc/en-us).

<img src="img/databricks_sql_add_data_source.png" alt="Add a Databricks SQL Data Source" style="width:600px;"/><br>

> **Configure the Databricks SQL Data Asset**
> 1. On the **Select tables to import as Data Assets** page, check the box next to `nyc_taxi_data`.
> 1. Click **Add 1 Asset**.

<img src="img/databricks_sql_add_data_asset.png" alt="Add a Databricks SQL Data Asset" style="width:600px;"/><br>

Congratulations! You have successfully added a Databricks SQL Data Asset to your GX Cloud organization.

## Create Expectations
Expectations are a unique GX construct that enable you to make simple, declarative assertions about your data. You can think of Expectations as unit tests for your data. They make implicit assumptions about your data explicit, and they use self-explanatory language for describing data. Expectations can help you better understand your data and help you improve data quality.

In GX Cloud, you create Expectations within an Expectation Suite, which is a collection of Expectations.

The Databricks SQL Data Asset schema contains New York City (NYC) taxi trip data. The [NYC Taxi data](https://www.nyc.gov/site/tlc/about/tlc-trip-record-data.page) is a popular set of open source data that contains records of completed taxi cab trips in NYC, including information such as pick up and drop off times, the distance of the trip, the fare collected, and so on.

You'll create Expectations to validate the taxi data. New Expectations are selected from the Expectation picker.

<img src="../common/img/expectation_picker.png" alt="Create a missingness Expectation" style="width:500px;"/><br>

Your first Expectation will expect that there is an associated vendor for each taxi trip. You expect that you should not see any null `vendor_id` values.

> **Create your first Expectation**
> 1. In the **Data Assets** list, click the `nyc_taxi_data` Data Asset.
> 1. Click the **Overview** tab and then **New Expectation**.
> 1. Click the **Expect Column Values To Not Be Null** Expectation.
> 1. Create an Expectation that verifies that there is an associated vendor for each taxi trip:
>
>    1. In the **Column** field, select `vendor_id` from the dropdown.
>    1. Click **Save**.

<img src="../common/img/new_expectation.png" alt="Create a missingness Expectation" style="width:500px;"/><br>

Once created, your first Expectation is displayed on the Data Asset Expectations page.

Create a second Expectation that checks the passenger count values to determine if the maximum allowable capacity of four passengers is exceeded on any given trip. Typically, trips don't accommodate more than four passengers, since there are normally only four passenger seats in a taxi vehicle.

> **Create your second Expectation**
>
> Create an Expectation that asserts that there are no more than four passengers for any trip:
>   1. Click back on the **Overview** tab and click on **New Expectation**.
>   1. Click the **Expect Column Max To Be Between** Expectation.
>   1. In the **Column** field, select `passenger_count` from the dropdown.
>   1. In the **Min Value** field, enter `4`.
>   1. In the **Max Value** field, enter `4`.
>   1. Leave the other fields blank.
>   1. Click **Save**.

<img src="../common/img/new_passenger_expectation.png" alt="Create a column max Expectation" style="width:500px;"/><br>

Your new `vendor_id` and `passenger_count` Expectations appear in the Data Asset **Expectations** list under "Taxi data - Default Expectation Suite".

## Validate a Data Asset
You have successfully created two Expectations. Now, make sure that they pass as expected when you validate your Data Asset.

> **Validate your Data Asset**
>
> On the Data Asset **Expectations** page, click **Validate**.

<img src="../common/img/validate_1.png" alt="Validate a Data Asset" style="width:800px;"/><br>

After you click **Validate**, GX Cloud queries the data in Databricks based on the defined Expectations. GX Cloud uses the query results to determine if the data fails or meets your Expectations.

After validation is completed, a notification appears indicating that the Validation results are ready. To view the results, you can either click on the link provided in the notification, or click on the Data Asset **Validations** tab.

<img src="../common/img/validation_result_1.png" alt="Validation results with passing and failing Expectations" style="width:700px;"/><br>

You can see that the `passenger_count` Expectation has failed. This is because some of the larger New York City taxis in NYC can carry up to six passengers.

## Update the failing Expectation and run the Validation again
Now that you know your assumption about taxi passenger capacity was incorrect, you need to update the Expectation so the Validation of the `passenger_count` Expectation passes.

> **Update your Expectation**
> 1. Click the **Expectations** tab.
> 1. Click **Edit** (the pencil icon) for the `passenger_count` Expectation.
> 1. In the **Max Value** field, change `4` to `6`.
> 1. Click **Save**.

After the Expectation is updated, run the Validation again. When the notification indicating the Validation was successful appears, click the link in the notification or click the **Validations** tab. The `passenger_count` Expectation was successful. You can view the history of your Data Asset Validations by clicking **All Runs** below **Batches & run history**.

<img src="../common/img/validation_result_2.png" alt="Validation results with all passing Expectations" style="width:700px;"/><br>

## Profile Data
You might wonder if there is an easier way to create your Expectations instead of making assumptions or manually inspecting the data. Thankfully, GX Cloud lets you profile your data directly, so that you don't have to!

When you profile the data for a Data Asset, GX Cloud profiles the Data Asset and returns a collection of descriptive metrics including column types, statistical summaries, and null percentages.

> **Profile Data for a Data Asset**
> 1. Click the Data Asset **Overview** tab. Basic information about your Data Asset is displayed in the **Data Asset Information** pane.
> 1. Click the **Profile Data** button.

<img src="img/databricks_sql_profile_data.png" alt="Profile data button for Databricks SQL Data Asset" style="width:700px;"/><br>

When the process completes, an updated view of your Data Asset appears. You can see the Data Asset row count as well as some key information about each of the columns. Take some time now to review the data included in metrics.

<img src="img/fetch_databricks_sql_metrics.png" alt="Data Asset Metrics" style="width:700px;"/><br>

When you have profiled the data for a Data Asset, you can use the introspection results when creating new Expectations. Let's create a new Expectation for this Data Asset. Note the several subtle, but key, changes on the Expectation creation page.

* When selecting new Expectations types, the **Column** input provides a dropdown menu of existing Data Asset columns, rather than a freeform text field.

* Depending on the Expectation type and column selected, default values are populated automatically.

> **Examine creating a new Expectation using profiled data**
> 1. Click **New Expectation**.
> 1. Click the **Expect Column Max To Be Between** Expectation.
> 1. In the **Column** menu, select `passenger_count`.
> 1. The value `6` is automatically added to the **Min Value** and **Max Value** fields.

<img src="../common/img/new_expectation_with_metrics.png" alt="Create a new Expectation using Data Asset Metrics" style="width:500px;"/><br>

## Conclusion
Congratulations! You've successfully completed the GX Cloud Databricks SQL Workshop. You have created a Databricks SQL Data Source and Data Asset, created Expectations, run some Validations, and fetched Metrics for your data. We hope you have a better understanding of how GX Cloud works and how it can work within your data pipeline.

## What's next?
* [Connect to your own Databricks SQL warehouse](https://docs.greatexpectations.io/)
* [Create your own Expectations in GX Cloud](https://docs.greatexpectations.io/docs/cloud/expectations/manage_expectations)
* Use the [GX Python API](https://docs.greatexpectations.io/docs/oss/) to create Data Sources, Data Assets, Expectations, Expectation Suites, and Checkpoints
* Connect to GX Cloud from an orchestrator (for example, [Airflow](https://airflow.apache.org/))
* [Invite others](https://docs.greatexpectations.io/docs/cloud/users/manage_users#invite-a-user) to work in your GX Cloud organization
* Explore our [documentation](https://docs.greatexpectations.io/docs/cloud/)
