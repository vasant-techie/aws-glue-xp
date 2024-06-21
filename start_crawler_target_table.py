# Create a Glue client
glue_client = boto3.client('glue')

# Define the crawler name and the table-specific configuration
crawler_name = 'your_crawler_name'
database_name = 'your_database_name'
table_name = 'your_table_name'
s3_target_path = 's3://your-bucket/path-to-your-table/'

# Update the crawler to target the specific table
response = glue_client.update_crawler(
    Name=crawler_name,
    Targets={
        'S3Targets': [
            {
                'Path': s3_target_path,
                'Exclusions': [],
            },
        ],
        'JdbcTargets': [],
        'DynamoDBTargets': [],
        'CatalogTargets': [
            {
                'DatabaseName': database_name,
                'Tables': [table_name]
            },
        ]
    }
)

print(f'Updated crawler: {crawler_name} to target table: {table_name}')

# Start the crawler
response = glue_client.start_crawler(Name=crawler_name)

print(f'Started crawler: {crawler_name}')
