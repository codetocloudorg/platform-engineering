import argparse
from pydantic import BaseModel, Field
from openai import AzureOpenAI

class ProposedCodeChangesPydantic(BaseModel):
    path: str = Field(description="The path to the source file. ie: docs/dagger/dagger-hackathon/src/file.py")
    line: str = Field(description="The line number. ie: 10")
    change: str = Field(description="The proposed code change. ie: return 8 * 6")

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--response", required=True, help="The LLM response to structure")
    parser.add_argument("--endpoint", required=True, help="The Azure OpenAI Endpoint")
    parser.add_argument("--model", required=True, help="The Azure OpenAI Model")
    args = parser.parse_args()

    client = AzureOpenAI(
        azure_endpoint=args.endpoint,
        api_version="2024-12-01-preview"
    )

    completion = client.beta.chat.completions.parse(
        model=args.model,
        messages=[
            {"role": "system", "content": "Extract the information."},
            {"role": "user", "content": args.response},
        ],
        response_format=ProposedCodeChangesPydantic,
    )

    structured_output = completion.choices[0].message.parsed

    print(structured_output)

if __name__ == "__main__":
    main()
