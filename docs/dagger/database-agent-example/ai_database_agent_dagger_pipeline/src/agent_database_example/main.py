import dagger
from dagger import dag, function, object_type, Doc
from typing import Annotated

@object_type
class AgentDatabaseExample:
    @function
    async def query_db(
        self, svc: Annotated[dagger.Service, Doc("Host service")], table_name: str
    ) -> str:
        """Send a query to a PostgreSQL service and return the response."""
        return await (
            dag.container()
            .from_("postgres:16")
            .with_service_binding("db", svc)
            .with_env_variable("PGPASSWORD", "postgres") # handle this better, from .env
            .with_exec(
                [
                    "psql",
                    "-h", "db",
                    "-U", "postgres",
                    "-d", "postgres",
                    "-c", "SELECT * FROM {};".format(table_name)
                ]
            )
            .stdout()
        )
    @function
    async def ask_agent(self, svc: Annotated[dagger.Service, Doc("Host service")], table_name: str, question: str) -> str:
        """
        Ask an LLM a question based on a SQL table's contents.
        """
        table_contents = await self.query_db(svc, table_name)

        prompt = f"""
        You are an expert database administrator.
        You have been given the contents of a SQL table:
        {str(table_contents)}

        Given the contents above, answer the following question:

        The question is: {question}

        DO NOT STOP UNTIL YOU HAVE ANSWERED THE QUESTION COMPLETELY.
        """

        return await (
            dag.llm()
            .with_prompt(prompt)
            .last_reply()
        )