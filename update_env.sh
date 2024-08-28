#!/bin/bash

# Inform the user that the script is starting
echo "🚀 Starting to fetch credentials from 1Password..."

# Fetch the credential from 1Password and store it in a variable
echo "🔑 Fetching ANTHROPIC_API_KEY..."
ANTHROPIC_API_KEY=$(op read "op://Employee/Claude/credential")
echo "✅ ANTHROPIC_API_KEY fetched successfully."

echo "🔑 Fetching TAVILY_API_KEY..."
TAVILY_API_KEY=$(op read "op://Employee/Tavily/credential")
echo "✅ TAVILY_API_KEY fetched successfully."

# Inform the user that the script is updating the .env file
echo "📝 Updating .env file..."

# Append or update the credentials in the .env file
sed -i '' '/^ANTHROPIC_API_KEY=/d' .env
echo "ANTHROPIC_API_KEY=$ANTHROPIC_API_KEY" >> .env
echo "✅ ANTHROPIC_API_KEY added to .env."

sed -i '' '/^TAVILY_API_KEY=/d' .env
echo "TAVILY_API_KEY=$TAVILY_API_KEY" >> .env
echo "✅ TAVILY_API_KEY added to .env."

# Inform the user that the process is complete
echo "🎉 All done! .env file has been updated successfully."
