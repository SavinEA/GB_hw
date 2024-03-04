from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from airflow.hooks.postgres_hook import PostgresHook
from datetime import datetime
from os import remove


def dump_data(table):
    phook = PostgresHook(postgres_conn_id="pg_stage")
    conn = phook.get_conn()
    with conn.cursor() as cur:
        with open(f"{table}.csv", "w") as f:
           cur.copy_expert(f"COPY public.{table} TO STDOUT WITH DELIMITER ',' CSV HEADER;", f) 

def load_data(table):
    phook = PostgresHook(postgres_conn_id="pg_core")
    conn = phook.get_conn()
    with conn.cursor() as cur:
        with open(f"{table}.csv", "r") as f:
           cur.copy_expert(f"COPY stage.{table} FROM STDIN WITH DELIMITER ',' CSV HEADER;", f) 

def drop_tmp_file(table):
    try:
        remove(f"{table}.csv") 
    except:
        print(f"no file: {table}.csv")


table_list = ('orders', 'products', 'suppliers', 'orderdetails', 'productsuppl')
DEFAULT_ARGS = {
    "owner": "airflow",
    "start_date": datetime(2024, 3, 1),
    "retries": 1,
    "email_on_failure": False,
    "email_on_retry": False,
    "depends_on_past": False,
}

with DAG(
    dag_id="transfer_tables",
    default_args=DEFAULT_ARGS,
    schedule_interval=None,
    tags=['gb'],
    catchup=False
) as dag:
        

    for table in table_list:

        dump_tables = PythonOperator(
            task_id = f'dump_data_{table}',
            python_callable = dump_data,
            op_kwargs={"table": table}
        )

        load_tables = PythonOperator(
            task_id = f'load_data_{table}',
            python_callable = load_data,
            op_kwargs={"table": table}
        )

        drop_file = PythonOperator(
            task_id = f'drop_tmp_file_{table}.csv',
            python_callable = drop_tmp_file,
            op_kwargs={"table": table}
        )

        dump_tables >> load_tables >> drop_file
