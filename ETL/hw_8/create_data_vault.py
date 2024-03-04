from airflow import DAG
from airflow.operators.postgres_operator import PostgresOperator
from datetime import datetime


DEFAULT_ARGS = {
    "owner": "airflow",
    "start_date": datetime(2024, 3, 1),
    "retries": 1,
    "email_on_failure": False,
    "email_on_retry": False,
    "depends_on_past": False,
}

with DAG(
    dag_id="create_data_vault",
    default_args=DEFAULT_ARGS,
    schedule_interval=None,
    tags=['gb'],
    catchup=False
) as dag:
        

    create_data_vault = PostgresOperator(
    task_id='create_data_vault',
    postgres_conn_id='pg_core',
    sql="sql/create_data_vault.sql"
    )