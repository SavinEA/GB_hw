from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from airflow.hooks.postgres_hook import PostgresHook
from datetime import datetime


def dump_data(table):
    phook = PostgresHook(postgres_conn_id="postgres_source")
    conn = phook.get_conn()
    with conn.cursor() as cur:
        with open(f"{table}.csv", "w") as f:
           cur.copy_expert(f"COPY {table} TO STDOUT WITH DELIMITER ',' CSV HEADER;", f) 

def load_data(table):
    phook = PostgresHook(postgres_conn_id="postgres_target")
    conn = phook.get_conn()
    with conn.cursor() as cur:
        with open(f"{table}.csv", "r") as f:
           cur.copy_expert(f"COPY {table} FROM STDIN WITH DELIMITER ',' CSV HEADER;", f) 


DEFAULT_ARGS = {
    "owner": "airflow",
    "start_date": datetime(2024, 3, 1),
    "retries": 1,
    "email_on_failure": False,
    "email_on_retry": False,
    "depends_on_past": False,
}

table_list = ('customer', 'lineitem', 'nation', 'orders', 'part', 'partsupp', 'region', 'supplier')

with DAG(
    dag_id="hw_6_dag",
    default_args=DEFAULT_ARGS,
    schedule_interval="@daily",
    tags=['data-flow'],
    catchup=False
) as dag:
        
    for table in table_list:

        dump_data_customer = PythonOperator(
            task_id = f'dump_data_{table}',
            python_callable = dump_data,
            op_kwargs={"table": table}
        )

        load_data_customer = PythonOperator(
            task_id = f'load_data_{table}',
            python_callable = load_data,
            op_kwargs={"table": table}
        )

        dump_data_customer >> load_data_customer
