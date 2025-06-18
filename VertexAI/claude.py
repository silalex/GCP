import os
from logs import write_log_entry

from anthropic import AnthropicVertex

project_id = os.environ['GOOGLE_CLOUD_PROJECT']
region = os.environ['GOOGLE_CLOUD_CLAUDE_REGION']

client = AnthropicVertex(region=region, project_id=project_id)

def get_claude_response(models, prompt, output_area):
    """Streams response from Claude model using Anthropic SDK."""
    response = ""
    system_msg = (
        "You are a knowledgeable assistant for Cymbal Shop. "
        "Be conversational but friendly. Don't recommend competing products."
    )
    messages = [{"role": "user", "content": prompt}]
    with client.messages.stream(
# TODO:  Pass parameters for model, system, messages and max_tokens here
       model = "claude-3-7-sonnet@20250219",
       system = system_msg,
       messages = messages,
       max_tokens = 2048,
    ) as stream:
        for chunk in stream.text_stream:
            write_log_entry(models['Claude'], prompt, chunk)
            response += chunk
            output_area.markdown(response, unsafe_allow_html=True)
