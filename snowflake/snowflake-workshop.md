# GX Cloud Snowflake Workshop

## Introduction
Welcome to the Great Expectations Cloud Snowflake Workshop! In this workshop, you will learn how to connect your GX Cloud account to a Snowflake Data Source, create Expectations and run Validations. 

## Prerequisites
In order to run through this workshop correctly, you will need to have the following:
- Your own [GX Cloud](https://app.greatexpectations.io/login?ssac=true) account
- [Docker Desktop](https://docs.docker.com/get-docker/) installed and running on your own machine
- Credentials for the shared [GX Workshop Snowflake](https://vntumnu-gx_workshops.snowflakecomputing.com/) instance. Please [reach out to us](mailto:support@greatexpectations.io) if you do not have an account!

### Step 1 - Login and Start the GX Agent
Start by logging into [GX Cloud](https://app.greatexpectations.io/login). When you have done so, you will need to create a User Access token that the GX Agent will use to authenticate itself to your GX Cloud organization. Head to the Tokens page under Settings. Create a new user access token by giving it a name. Once the token is created, copy the value and store it some place safe. You'll only see this value once!

![User Token](../img/snowflake/User-Token.png)

Next, go to the GX Agent page where you will see a Docker command. This is used to run the GX Agent locally. Copy the command into a terminal window, making sure to replace the `GX_CLOUD_ACCESS_TOKEN` value with the token you just generated. Running this command will start a Docker image that uses the latest version of GX. It may take a few minutes to download the image. Once it is done, your terminal will have an output of `The GX Agent is ready.`

### Step 2 - Create a Snowflake Data Source and Data Asset
Now that the Agent is running, we are ready to connect to Snowflake. Click on the Data Assets page, then on New Data Asset and finally on Snowflake. Give your Data Source a name, e.g. `GX Workshop Snowflake`, and enter in your Snowflake username and password. The account identifier for the Snowflake account is `VNTUMNU-GX_WORKSHOPS`. The database name we'll be using is `GXWORKSHOP` with a Schema of `PUBLIC`, a Warehouse of `COMPUTE_WH` and the role of `PUBLIC`. Be sure to check the "Test connection" checkbox before you click on Continue.

![Data Source](../img/snowflake/Add-Data-Source.png)

Congratulations! You have successfully added a Data Source to your GX Cloud organization. The last thing we'll do in this step is to add a Data Asset. Give your Data Asset a name, e.g. `Taxi Data`, which points to a table name of `TAXI_DATA`. Click on Save to complete the process.

### Step 3 - Create Expectations
Now that you have created a Data Asset, click into the record. On the following page, click on the New Expectation button at the top righthand corner of the screen. We will be creating a new Expectation Suite, so start by giving it a name, e.g. `GX Workshop Suite`.

The data set that we are using is New York City taxi data from January 2019. This data has all of the trips that were completed by two taxi companies in New York City for that month, including information like the vendor, the number of passengers, the fare collected, etc. The first expectation we will create ensures that there is always an associated vendor with a given trip (or row). Start by selecting `expect_column_values_to_not_be_null` under Missingness. On the righthand side, enter `vendor_id` into the Column field. Click  "Save & Add More".

![New Missingness Expectation](../img/snowflake/New-Expectation.png)

The second Expectation we will be adding is to check the values of the passenger count. Typically, we know that taxis should have no more than 4 passengers since there are only 4 seats. Select `expect_column_max_to_be_between` and then enter in `passenger_count` into the Column field. The Min Value should be 1, and the Max Value should be 4. Click on "Save", which will close this panel. You will now see the two Expectations listed.

![New Column Max Expectation](../img/snowflake/New-Passenger-Expectation.png)

### Step 4 - Validate the Expectations
We have successfully created some Expectations on our data, so let's make sure they are running as we'd expect. From the same screen click on the Validate button in the top righthand corner. After a few moments, you will receive a toast notification to tell you that the results are ready. You can either click on the link on the toast notification itself, or click on the Validations tab.

![Validate](../img/snowflake/Validate-1.png)

You will see that while the Validation has run, the `passenger_count` Expectation has failed. This is because we failed to recognize that some taxis in New York can hold up to 6 people! 

![Validation Result 1](../img/snowflake/Validation-Result-1.png)

### Step 5 - Fix the Failing Expectation and Re-run the Validation
Let's fix the Expectation so that it has the right values. Click back to the Expectations page within the Data Asset. On the `passenger_count` Expectation, click on the pencil icon to edit the Expectation. Update the Max Value from `4` to `6` and then click on Save.

We can now re-run the Validation by clicking on Validation once again on the top righthand corner of the screen. Once the validation has run (look for the notification!), click back to the Validations screen to view the new results. You will see that the Expectations are now passing as expected.

![Validation Result 2](../img/snowflake/Validation-Result-2.png)

### Step 6 - Fetching Metrics
Now, you might be wondering if there is a better and easier way to set up your Expectations, instead of guessing at values or manually inspecting the data. Thankfully, GX Cloud allows you to fetch the metrics from your data directly so that you don't have to! Head back to the Overview page of your Data Asset. You will see some basic information about your asset on the left hand side. However, on the main panel, you will see a button labeled. "Fetch Metrics". Click on that button and allow the system to analyze your data. 

Once the Metrics have completed, you will be presented with an updated view of your data. You will see that the Data Asset contains 10,000 rows, as well as some key information about each of the columns. Feel free to take some time now to review some of the data shown here.

![Metrics](../img/snowflake/Metrics.png)

When you are ready, click on New Expectation in the top righthand corner one last time. Now that we have fetched the metrics on the data, there are a few subtle, but key changes that you will notice on this page. First, whenever you select an Expectation on the lefthand side, the Column field has changed from a free text field into a dropdown where you can select the specific column you'd like to test. Furthermore, if you select a `Values and Statistics` Expectation, choosing a column will auto-fill some of the values for you.

For example, click on the `expect_column_max_to_be_between` Expectation and select `passenger_count` in the Column dropdown. You will see that since the metrics have been generated for this data set, the Values have been automatically filled in with `6`.

![New Expectation With Metrics](../img/snowflake/New-Expectation-With-Metrics.png)

## Conclusion
Congratulations! You've successfully completed the workshop. By now, you will have created a Snowflake Data Source and Data Asset, created Expectations, run some Validations and fetched some metrics on the data. We hope you have a better understanding of how GX Cloud works and how it can work within your data pipeline.

### What's next?
- Connect to your own Snowflake instance
- Try creating your own Expectations in GX Cloud
- Use the [GX API]() to create Data Sources, Data Assets, Expectations, Expectation Suites, and Checkpoints
- Connect to GX Cloud from an orchestrator (e.g. [Airflow](https://airflow.apache.org/))
- Invite others to work in your GX Cloud organization
- Explore our [documentation](https://docs.greatexpectations.io/docs/cloud/)